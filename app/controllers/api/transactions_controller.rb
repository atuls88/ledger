class Api::TransactionsController < ApplicationController
	def index
 		transactions = Transaction.order("created_at DESC")
 		render json: {status: 'SUCCESS', message:'Transactions ledgers', data: transactions}, status: :ok
 	end

 	def create
 		transaction = Transaction.new(transaction_params)
 		if transaction.save
			render json: {status: 'SUCCESS', message:'Saved transaction', data: transaction}, status: :ok
		else
			render json: {status: 'ERROR', message:'Ledger not saved', data: transaction.errors}, status: :unprocessable_entity
		end
 	end

 	def create_transaction
 		ledger = Ledger.find(params[:ledger_id])
 		transaction = Transaction.new(transaction_params)
 		ledger.transactions << transaction
 		if ledger.save
 			render json: {status: 'SUCCESS', message:'Transaction saved', data: transaction}, status: :ok
 		else
 			render json: {status: 'ERROR', message:'Transaction not updated', data: transaction.errors}, status: :unprocessable_entity
 		end
 	end

 	def list_transactions
 		ledger = Ledger.find(params[:ledger_id])
 		transactions = ledger.transactions.order("created_at DESC")
 		render json: {status: 'SUCCESS', message:'Transactions ledgers', data: transactions}, status: :ok
 	end


 	private
 	def transaction_params
 		params.permit(:amount, :date, :type, :description)
 	end
end
