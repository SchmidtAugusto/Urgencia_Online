class HospitalsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_hospital, only: %i[show]

  def show
    @coverages = Coverage.where(hospital_id: @hospital)
    authorize @hospital
  end

  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end
end
