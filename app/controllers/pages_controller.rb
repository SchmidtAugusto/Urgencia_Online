class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :help]
  before_action :set_user, only: %i[account_details plan_details medical_data]

  def home
    @hospitals = Hospital.all

    if params[:query].present?
      @hospitals = Hospital.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @hospitals = Hospital.all
    end
  end

  def account_details
  end

  def help
  end

  def plan_details
    @plan_detail = PlanDetail.find_by(user_id: @user)
  end

  def medical_data
    @medical_data = MedicalRecord.find_by(user_id: @user)
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :cpf, :birthdate, :address, :photo)
  end
end
