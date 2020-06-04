class SessionsController < ApplicationController
  
  def new 

  end

  def create
    if auth && User.find_by(email: auth[:info]['email'])
      @user = User.find_by(email: auth[:info]['email'])
    	session[:user_id] = @user.id
    	redirect_to user_path(@user)
    elsif auth && !User.find_by(email: auth[:info]['email'])
      @user = User.new(name: auth[:info]['name'], email: auth[:info]['email'], password: "omniauth", password_confirmation: "omniauth")
      @user.save
      session[:user_id] = @user.id
    	redirect_to user_path(@user)
    elsif User.find_by(name: params[:session][:name])
      @user = User.find_by(name: params[:session][:name])
      if @user && @user.authenticate(params[:session][:password])
        session[:user_id] = @user.id
      redirect_to user_path(@user)
      end
    else
      redirect_to root_url
    end
  end

  def destroy 
    if session[:user_id] != nil 
      session.delete :user_id
    end
    redirect_to root_url
  end

  private

	def auth
	   request.env['omniauth.auth']
	end

end