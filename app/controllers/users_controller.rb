class UsersController < ApplicationController

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: @user
  end

  def check_email
    render json: User.find_by(email: params[:email]).blank?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user.token, status: :created, location: @user
    else
      puts @user.errors
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    if params[:auth_token].present?
      user = User.find_by(token: params[:auth_token])
    else
      user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    end
    
    if user
      create_device(user, params[:uuid], params[:model], params[:platform], params[:version], params[:device_token])
      render :json => { result: 'success', user: user.to_json }
    else
      render :json => { :result => 'error' }
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def create_device(user, uuid, model, platform, version, token)
      device =  Device.find_by(uuid: uuid, user: user)
      if uuid && token && device.blank?
        device = Device.new
        device.user     = user
        device.uuid     = uuid
        device.model    = model
        device.platform = platform
        device.version  = version
        device.token    = token
        device.save
      end
    end
end
