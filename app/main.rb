require 'sinatra/base'
require 'active_record'
require 'logger'
require 'pry'
require_relative './controllers/functions'

class Sample < Sinatra::Base
  helpers do
  end
  
  before do
  end
  
  get "/" do
    erb :home
  end
  
  get "/add/term" do
    erb :add_term
  end
  
  post "/add/term" do
    name = params[:name]
    new_term = Term.create({:name => name})
    
    redirect to("/term/#{new_term.id}")
  end
  
  get "/list/term" do
    @terms = Term.all
    erb :list_term
  end
  
  get "/term/:id" do
    @term = Term.find(params[:id])
    erb :term
  end
end