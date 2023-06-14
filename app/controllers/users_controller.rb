class UsersController < ApplicationController
  def update
    @user = User.find(params[:id])
    authorize @user

    if @user.update(user_params)
      redirect_to account_details_path, notice: 'Dados atualizados com sucesso!'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :cpf, :birthdate, :address, :photo)
  end
end
