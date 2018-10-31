Rottenpotatoes::Application.routes.draw do
  resources :movies
  get 'movies/:id/similar', to: 'movies#show_movies_director', as: 'movies_director'
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
