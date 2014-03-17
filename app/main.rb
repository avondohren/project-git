require 'sinatra/base'
require_relative './controllers/functions'

class Sample < Sinatra::Base
  helpers do
  end
  
  before do
  end
  
  get "/" do
    erb :home
  end
  
  get "/list/klasses" do
    @klasses = Klass.all
    
    erb :list_klasses
  end
end