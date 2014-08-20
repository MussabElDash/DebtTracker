class DebtsController < ApplicationController
	before_action :set_debt, only: [:show, :edit, :update, :destroy]

	def index
	end

	def create
		@debt = Debt.new(debt_params)
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

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_debt
			@debt = Debt.find(params[:id])
		end

		def debt_params
			params.require(:debt).permit(:creditor, :debtor, :currency, :amount, :remaining)
		end
end
