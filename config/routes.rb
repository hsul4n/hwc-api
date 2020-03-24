Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # api
  namespace :api, defaults: { format: :json } do
    
    # api/v1
    namespace :v1 do

      # api/v1/geo
      namespace :geo do
        # /api/v1/geo/continents
        resources :continents, only: [:index, :show] do
          # api/v1/geo/continents/1/countries
          resources :countries, only: [:index, :show]
        end
        
        # api/v1/geo/countries
        resources :countries, only: [:index, :show] do
          scope module: :country do
            # api/v1/geo/countries/1/division
            namespace :division do
              # api/v1/geo/division/levels
              resources :levels, only: [:index, :show]
              # api/v1/geo/division/level1
              resources :level1, only: [:index, :show]
            end
          end
        end
      end

      # api/v1/medical
      namespace :medical do
        # api/v1/medical/diseases
        resources :diseases, only: [:index, :show] do
          scope module: :disease do 
            # api/v1/geo/diseases/1/cases
            resources :cases, only: [] do
              collection do
                # api/v1/medical/diseases/1/cases/total
                get :total
                # api/v1/medical/diseases/1/cases/timeline
                get :timeline
              end
            end
          end
        end
      end
    end
  end
end
