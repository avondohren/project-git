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
  
  get "/list/classes" do
    @klasses = Klass.all
    
    erb :list_klasses
  end
  
  get "/add/class" do
    erb :add_klass
  end
  
  post "/add/class" do
    new_klass = Klass.create({
      :term_id => params[:term_id],
      :name => params[:name],
      :teacher_id => params[:teacher_id]
    })
    
    redirect to("class/#{new_klass.id}")
  end
  
  get "class/:id" do
    @klass = Klass.find(params[:id])
    erb :klass
  end
end