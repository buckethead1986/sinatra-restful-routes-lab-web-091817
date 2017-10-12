require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do

  end

  get '/recipes/new' do #form to input a new recipe
    erb :new
  end

  get '/recipes' do #redirected here after 'post /recipes'
    @recipes = Recipe.all
    erb :index
  end

  post '/recipes' do #post action from '/new' form.
    recipe = Recipe.create(params)

    redirect to "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  # post '/recipes/:id' do
  #   recipe = Recipe.find_by_id(params[:id])
  #
  #   redirect to "/recipes/#{@recipe.id}"
  # end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  post '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save

    redirect to "/recipes/#{@recipe.id}"
  end

  post '/recipes/:id/delete' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect '/recipes'
  end
end
