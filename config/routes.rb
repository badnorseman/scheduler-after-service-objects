Rails.application.routes.draw do
  # The priority is based upon order of creation: first created has highest priority.
  # See how all your routes lay out with 'rake routes'. Read more: http://guides.rubyonrails.org/routing.html

  scope "/api" do
    mount_devise_token_auth_for "User", at: "/auth"
    resources :availabilities, except: [:new, :edit]
    resources :bookings, except: [:new, :edit]
    resources :exercise_plans, except: [:new, :edit]
    resources :exercise_plan_logs, except: [:new, :edit]
    resources :exercise_sessions, except: [:index, :new, :edit]
    resources :exercise_session_logs, except: [:index, :new, :edit]
    resources :exercise_sets, except: [:index, :new, :edit]
    resources :exercise_set_logs, except: [:index, :new, :edit]
    resources :exercises, except: [:index, :new, :edit]
    resources :exercise_logs, except: [:index, :new, :edit]
    resources :exercise_descriptions, except: [:new, :edit]
    resources :tags, except: [:new, :edit]
    resources :taggings, only: [:index, :create, :destroy]
    resources :habits, except: [:new, :edit]
    resources :habit_descriptions, except: [:new, :edit]
    resources :habit_logs, except: [:new, :edit]
    resources :payment_plans, except: [:new, :edit]
    resources :payments, except: [:new, :edit]
    resources :roles, except: [:new, :edit]
    resources :users, only: [:index, :show] do
      resources :products, except: [:new, :edit]
    end

    get "users/:id/profile", to: "profiles#show", as: "user_profile"
    post "users/:id/profile", to: "profiles#create", as: "create_user_profile"
    put "users/:id/profile", to: "profiles#update", as: "update_user_profile"

    get "users/:id/roles", to: "roles_to_users#index", as: "user_roles"
    post "users/:id/roles/:role_id", to: "roles_to_users#create", as: "create_user_role"
    delete "users/:id/roles/:role_id", to: "roles_to_users#destroy", as: "delete_user_role"
  end

  root to: "welcome#index"
end
