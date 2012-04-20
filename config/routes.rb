Raffler::Application.routes.draw do

  scope "api" do
    resources :entries
    resources :companies
  end

  root to: "main#index"
  match '*path', to: 'main#index'
end