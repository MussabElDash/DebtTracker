class UsersController < ApplicationController
	before_action :set_user, only: [:show]
	def index
	end

	def show
	end

	def search
		@users = User.search_by_full_name(search_params[:id])
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_user
			@user = User.find(params[:id])
			redirect_to :root if current_user == @user
		end

		def search_params
			params.require(:search).permit(:id)
		end
end
