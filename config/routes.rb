Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope '/api' do
    resources :thermostat_reads, only: [:create, :show]
    resources :thermostats, only: [] do
      member do
        get :stats
      end
    end
  end
end
