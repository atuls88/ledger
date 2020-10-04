Rails.application.routes.draw do
  namespace :api do
  	resources :ledgers do 
  		collection do
  			get 'get_ledger_totals'
  			get 'get_current_balance'
  		end
  	end
	resources :transactions do 
	  	collection do
		    get 'list_transactions'
		    post 'create_transaction'
		end
	end
  end
end
