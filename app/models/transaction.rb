class Transaction < ApplicationRecord
	belongs_to :ledger
	
	validates :amount, presence: true
	validates :date, presence: true
	validates :type, presence: true

	self.inheritance_column = :type

	scope :expense, -> { where(type: 'Expense') }
	scope :revenue, -> { where(type: 'Revenue') }
	scope :by_year, -> (year) { where('extract(year  from date) = ?', year) }
	scope :by_month, -> (month) { where('extract(month  from date) = ?', month) }
end
