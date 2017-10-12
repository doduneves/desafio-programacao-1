class PurchasesController < ApplicationController
	def index
	end

	def new
		@purchase = Purchase.new
	end

	def create
		#criar o tratamento do arquivo e colocar nos params do model
		@purchase = Purchase.new
		
		if @purchase.save
			flash[:success] = 'Scene was successfully created.'
			redirect_to purchases_path
		end

	end
end
