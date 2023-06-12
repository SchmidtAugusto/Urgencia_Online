class HospitalsController < ApplicationController
  before_action :set_hospital, only: %i[show]

  def show
  end

  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end
end
