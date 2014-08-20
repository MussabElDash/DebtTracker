class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_action :authenticate!
	before_action :update_sanitized_params, if: :devise_controller?

private
	def update_sanitized_params
		devise_parameter_sanitizer.for(:sign_up) do |user|
			user.permit(:email, :user_name,
				:first_name, :last_name, :image,
				:password, :password_confirmation)
		end
		devise_parameter_sanitizer.for(:account_update) do |user|
			user.permit(:email, :user_name, :current_password,
				:first_name, :last_name, :image,
				:password, :password_confirmation)
		end
		devise_parameter_sanitizer.for(:sign_in) do |user|
			user.permit(:login, :username, :email, :password, :remember_me)
		end
	end

	def authenticate!
		unless user_signed_in? or params[:controller] == nil or params[:controller].include?"devise"
			flash[:notice] = "You're not logged in!"
			redirect_to :root
		end
	end
end
