class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show destroy]

  def show
    @appointment_queue_duration = queue_duration_calc(@appointment.position)
    @hospital = Hospital.find(@appointment.hospital_id)
    @hospitals = Hospital.all
    @markers =
      [{
        lat: @hospital.latitude,
        lng: @hospital.longitude
      }]
  end

  def new
    @appointment = Appointment.new
    @hospital = Hospital.find(params[:hospital_id])
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @hospital = Hospital.find(params[:hospital_id])
    @appointment.user = current_user
    @appointment.hospital = @hospital
    @appointment.position = Appointment.where(hospital_id: @hospital, done: false).count

    if @appointment.save
      redirect_to appointment_path(@appointment)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def queue_duration_calc(position)
    position_minutes = position * 20
    if position_minutes >= 60
      hours = position_minutes / 60
      remaining_minutes = position_minutes % 60
      if hours == 1
        "#{hours} hour and #{remaining_minutes} minutes"
      else
        "#{hours} hours and #{remaining_minutes} minutes"
      end
    else
      "#{position_minutes} minutes"
    end
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:user_id, :description, :hospital_id, :color_protocol, :done, :position)
  end
end
