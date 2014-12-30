Kpi::Engine.routes.draw do
  get 'semanal(/:tipo)' => 'semanal#index'
end
