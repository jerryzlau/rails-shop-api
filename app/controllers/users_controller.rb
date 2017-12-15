class UsersController < ApplicationController
  protect_from_forgery

  def show 
    @user = User.find(params[:id])
  end 

  def create 
    @user = User.new(user_params)
    if @user.save
      render :show
    else 
      render json: @user.errors.full_messages, status: 422
    end 
  end 

  def destroy 
    user = User.find(params[:id])
    if user 
      user.destroy
    else
      render json: ["User doesn't exist"], status: 404
    end 
  end 

  private 

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name)
  end 

end
