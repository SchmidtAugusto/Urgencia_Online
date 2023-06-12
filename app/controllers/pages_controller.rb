class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :help]

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
end
