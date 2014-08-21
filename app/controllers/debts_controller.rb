class DebtsController < ApplicationController
	before_action :set_debt, only: [:show, :edit, :update, :destroy, :confirm, :payfor]
	before_action :set_user, only: [:new_creditor, :new_debtor, :payfor]

	def index
	end

	def create
		@debt = Debt.new(debt_params)
		@debt.skip_confirmation! if @debt.debtor_id == current_user.id
		respond_to do |format|
			if @debt.save
				format.html {redirect_to :root}
				format.json {render :show, status: :created, location: @debt}
			else
				format.html {render :new}
				format.json {render json: @debt.errors, status: :unprocessable_entity}
			end
		end
	end

	def new
		@debt = Debt.new
	end

	def edit
	end

	def show
	end

	def update
	end

	def destroy
	end

	def new_creditor
		@debt = Debt.new(creditor_id: @user.id, debtor_id: current_user.id)
	end

	def new_debtor
		@debt = Debt.new(creditor_id: current_user.id, debtor_id: @user.id)
	end

	def confirm
		@debt.skip_confirmation! if @debt.debtor_id == current_user.id
		respond_to do |format|
			if @debt.save
				format.json {render :show, status: :confirmed, location: @debt}
			else
				format.json {render json: @debt.errors, status: :unprocessable_entity}
			end
			format.html {redirect_to :back}
		end
	end

	def payfor
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_debt
			@debt = Debt.find(params[:debt_id] || params[:id])
		end

		# Use callbacks to share common setup or constraints between actions.
		def set_user
			@user = User.find(params[:user_id] || params[:id])
			redirect_to :root if current_user == @user
		end

		def debt_params
			params.require(:debt).permit(:creditor_id, :debtor_id, :currency, :amount, :remaining)
		end
end
