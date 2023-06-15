class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :help]
  before_action :set_user, only: %i[account_details plan_details medical_data admin]

  def home
    @hospitals = Hospital.all
    @query = params[:query]
    if params[:query].present?
      @hospitals = Hospital.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @hospitals = Hospital.all
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "pages/hospital_card", locals: { hospitals: @hospitals, query: @query }, formats: [:html] }
    end
  end

  def account_details
  end

  def help
  end

  def plan_details
    @plan_detail = PlanDetail.find_by(user_id: @user)
    @plan_detail_new = PlanDetail.new(user_id: @user)
    @insurance_plans = InsurancePlan.all.order(:name)
  end

  def medical_data
    @medical_data = MedicalRecord.find_by(user_id: @user)
    @medical_record = MedicalRecord.new(user_id: @user)
  end

  def admin
    if @user.admin
      authorize @user
      @appointments = Appointment.where(hospital_id: 9, done: false).order(:id)
    else
      redirect_to root_path
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :cpf, :birthdate, :address, :photo)
  end

  def medical_data_params
    params.require(:medical_data).permit(:user_id, :blood_type, :allergies, :weight, :height, :health_conditions)
  end
end
