class Api::LedgersController < ApplicationController
	def index
		ledgers = Ledger.order("created_at DESC")
		render json: {status: 'SUCCESS', message:'Laoded ledgers', data: ledgers}, status: :ok
	end

	def show
		ledger = Ledger.find(params[:id])
		render json: {status: 'SUCCESS', message:'Laoded ledger', data: ledger}, status: :ok
	end

	def create
		ledger = Ledger.new(ledger_params)
		if ledger.save
			render json: {status: 'SUCCESS', message:'Saved ledger', data: ledger}, status: :ok
		else
			render json: {status: 'ERROR', message:'Ledger not saved', data: ledger.errors}, status: :unprocessable_entity
		end
	end

	def destroy
		ledger = Ledger.find(params[:id])
		ledger.destroy
		render json: {status: 'SUCCESS', message:'Deleted ledger', data: ledger}, status: :ok
	end

	def update
		ledger = Ledger.find(params[:id])
		if ledger.update(ledger_params)
			render json: {status: 'SUCCESS', message:'Updated ledger', data: ledger}, status: :ok
		else
			render json: {status: 'ERROR', message:'Ledger not updated', data: ledger.errors}, status: :unprocessable_entity
		end
	end

	def get_ledger_totals
		ledger_transactions = Ledger.where(id: params[:ledger_id]).includes(:transactions)
		total_expenses = ledger_transactions.first.transactions.expense
		expenses = total_expenses.by_year(params[:year]).by_month(params[:month])
		total_revenue = ledger_transactions.first.transactions.revenue
		revenues = total_revenue.by_year(params[:year]).by_month(params[:month])
		total_expense = expenses.sum(&:amount)
		total_revenue = revenues.sum(&:amount)
		ledger_totals = {:expenses => total_expense, :total_revenue => total_revenue}
		render json: {status: 'SUCCESS', message:'Laoded ledgers', data: ledger_totals}, status: :ok
	end

	def get_current_balance
		ledger_transactions = Ledger.where(id: params[:ledger_id]).includes(:transactions)
		starting_balance = ledger_transactions.first.starting_balance
		expense = ledger_transactions.first.transactions.expense
		revenue = ledger_transactions.first.transactions.revenue
		current_balance = starting_balance + revenue.sum(&:amount) - expense.sum(&:amount)
		render json: {status: 'SUCCESS', message:'Laoded ledgers', data: current_balance}, status: :ok
	end


	private
	def ledger_params
		params.permit(:name, :starting_balance)
	end
end
