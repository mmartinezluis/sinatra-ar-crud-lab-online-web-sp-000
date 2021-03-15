require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do	
    redirect to '/articles'
  end

#Reader action-Displyad all of the items in the index view
  get '/articles' do
    @articles = Article.all
    erb :index
  end

#Create action-uses a form to take input from user
  get '/articles/new' do
    erb :new
  end

#Create action- renders the output to the previously filled user form and uses the params from the form to create a new item and render the new item's show view
  post '/articles' do
    @article= Article.create(title: params[:article][:title], content:params[:article][:content])
    redirect to "/articles/#{@article.id}"
  end

#Reader action-finds an item and displays that item's show view
get '/articles/:id' do
  @article = Article.find_by(id: params[:id].to_i)
  erb :show
end

#Update action-find the item to edit and renders a form to edit the item
  get '/articles/:id/edit' do
    @article= Article.find(params[:id])
    erb :edit
  end

  #Update action-on the back end, the item is updated, then the updated item is displayed on the item's show's view
  patch '/articles/:id' do
    @article= Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{ @article.id }"
  end

  #Delete action-the item is displayed iwith a delete button underneath; upon click on teh button, the item is destroyed on the bakc end, and user is rederected to the index view
  delete '/articles/:id' do
    @article= Article.find(params[:id])
    @article.destroy
    redirect to "/articles"
  end

end
