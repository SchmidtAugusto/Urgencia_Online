class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show destroy]

  def show; end

  def new
  end

  def create
  end

  def destroy
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:user_id, :description, :color_protocol, :hospital_id, :done, :position)
  end
end
