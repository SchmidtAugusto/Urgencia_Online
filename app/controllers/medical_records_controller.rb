class MedicalRecordsController < ApplicationController
  def create
    @medical_data = MedicalRecord.new(medical_params)
    @medical_data.user = current_user
    @medical_data.save
    authorize @medical_data

    redirect_to medical_data_path
  end

  def update
    @medical_data = MedicalRecord.find(params[:id])
    authorize @medical_data

    if @medical_data.update(medical_params)
      redirect_to medical_data_path, notice: 'Informações médicas atualizadas!'
    else
      render :edit
    end
  end

  private

  def medical_params
    params.require(:medical_record).permit(:user_id, :blood_type, :allergies, :weight, :height, :health_conditions)
  end
end
