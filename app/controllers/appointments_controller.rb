class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show destroy]

  def show; end

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

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:user_id, :description, :hospital_id, :color_protocol, :done, :position)
  end
end
