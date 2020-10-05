class Transaction < ApplicationRecord
	belongs_to :ledger
	
	validates :amount, presence: true, numericality: true
	validates :date, presence: true
	validates :type, presence: true

	self.inheritance_column = :type

	scope :expense, -> { where(type: 'Expense') }
	scope :revenue, -> { where(type: 'Revenue') }
	scope :by_year, -> (year) { where('extract(year  from date) = ?', year) }
	scope :by_month, -> (month) { where('extract(month  from date) = ?', month) }

	def self.get_total_expense(ledger_id,year,month)
		ledger = Ledger.find(ledger_id)
		transactions = ledger.transactions
		expense = ledger.transactions.expense
	end

	def self.get_total_expense_by_date(ledger_id,year,month)
		total_expenses = self.get_total_expense(ledger_id,year,month)
		total_expenses_by_date = total_expenses.by_year(year).by_month(month)
	end

	def self.get_total_revenue(ledger_id,year,month)
		ledger = Ledger.find(ledger_id)
		transactions = ledger.transactions
		revenue = ledger.transactions.revenue
	end

	def self.get_total_revenue_by_date(ledger_id,year,month)
		total_revenues = self.get_total_revenue(ledger_id,year,month)
		total_revenues_by_date = total_revenues.by_year(year).by_month(month)
	end
end
