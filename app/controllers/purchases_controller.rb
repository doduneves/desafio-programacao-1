class PurchasesController < ApplicationController
	def index
		@purchases = Purchase.all
		@income = calculate_all_incomes(@purchases)
	end

	def new
		@purchase = Purchase.new
	end

	def create
		#criar o tratamento do arquivo e colocar nos params do model
		uploaded_file = params[:purchase][:file]

		if uploaded_file.respond_to?(:read)
			file_data = uploaded_file.read
		else
			flash[:warning] = 'One or more itens could not be saved.'
		end

		doc_instance = read_doc(file_data)

		all_itens_saved = false

		doc_instance.each do |d|
			instance_array = d.split("\t");

			purchase = Purchase.new(purchase_params)
			purchase.purchaser_name = instance_array[0].force_encoding('UTF-8')
			purchase.item_description = instance_array[1].force_encoding('UTF-8')
			purchase.item_price = instance_array[2].force_encoding('UTF-8')
			purchase.purchase_count = instance_array[3].force_encoding('UTF-8')
			purchase.merchant_address = instance_array[4].force_encoding('UTF-8')
			purchase.merchant_name = instance_array[5].force_encoding('UTF-8')

			if purchase.save
				all_itens_saved = true
			else
				all_itens_saved = false
			end
		end

		if all_itens_saved
			flash[:success] = 'All itens on file successfully imported.'
		else
			flash[:warning] = 'One or more itens could not be saved.'
		end
		redirect_to purchases_path

	end

	def read_doc(file_data)
		doc_instance = file_data.split("\n")
		doc_instance.shift
		return doc_instance
	end

	def calculate_all_incomes(purchases)
		income = 0
		purchases.each do |p|
			income += p.item_price * p.purchase_count
		end

		return income
	end

	private
		def purchase_params
			params.require(:purchase).permit(:purchaser_name, :item_description, :item_price, :purchase_count, :merchant_address, :merchant_name)
		end

end
