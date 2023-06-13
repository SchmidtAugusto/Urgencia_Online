class PlanDetailsController < ApplicationController
  def create
    @plan_detail = PlanDetail.new(plan_params)
    @plan_detail.user = current_user
    @plan_detail.save
    authorize @plan_detail

    redirect_to plan_details_path
  end

  def update
    @plan_detail = PlanDetail.find(params[:id])
    authorize @plan_detail

    if @plan_detail.update(plan_params)
      redirect_to plan_details_path, notice: 'Informações médicas atualizadas!'
    else
      render :edit
    end
  end

  private

  def plan_params
    params.require(:plan_detail).permit(:insurance_plan_id, :product, :id_code, :plan, :cns, :user_id)
  end
end
