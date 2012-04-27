Raffler::Application.routes.draw do

  scope "api" do
    resources :entries
    resources :companies
    resources :fundings
  end

  root to: "main#index"
  match '*path', to: 'main#index'
end