Kpi::Engine.routes.draw do
  get 'semanal(/:tipo)', to: 'semanal#index', as: 'semanal_index'
end
