class Api::LedgersController < ApplicationController
	
	def create
		ledger = Ledger.new(ledger_params)
		if ledger.save
			render json: {status: 'SUCCESS', message:'Saved ledger', data: ledger}, status: :ok
		else
			render json: {status: 'ERROR', message:'Ledger not saved', data: ledger.errors}, status: :unprocessable_entity
		end
	end

	def get_ledger_totals
		expenses = Transaction.get_total_expense_by_date(params[:ledger_id],params[:year],params[:month])
		revenues = Transaction.get_total_revenue_by_date(params[:ledger_id],params[:year],params[:month])
		ledger_totals = {:total_expenses => expenses.sum(&:amount), :total_revenue => revenues.sum(&:amount)}
		render json: {status: 'SUCCESS', message:'Laoded ledgers', data: ledger_totals}, status: :ok
	end

	def get_current_balance
		ledger = Ledger.find(params[:ledger_id])
		starting_balance = ledger.starting_balance
		transactions_expenses = Transaction.get_total_expense(params[:ledger_id],params[:year],params[:month])
		transactions_revenues = Transaction.get_total_revenue(params[:ledger_id],params[:year],params[:month])
		current_balance = starting_balance + transactions_revenues.sum(&:amount) - transactions_expenses.sum(&:amount)
		render json: {status: 'SUCCESS', message:'Laoded ledgers', data: current_balance}, status: :ok
	end


	private
	def ledger_params
		params.permit(:name, :starting_balance)
	end
end
