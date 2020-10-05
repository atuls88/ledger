class Ledger < ApplicationRecord
	has_many :transactions
	
	validates :name, presence: true
	validates :starting_balance, presence: true, numericality: true
end