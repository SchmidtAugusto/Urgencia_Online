class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @hospitals = Hospital.all

    if params[:query].present?
      @hospitals = Hospital.where("name ILIKE ?", "%#{params[:query]}%")
    else
      @hospitals = Hospital.all
    end
  end
end
