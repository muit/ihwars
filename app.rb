require "sinatra"
require "sinatra/reloader" if development?
require "json"
require "activerecord"

require 'date'
set :port, 3000
set :bind, '0.0.0.0'

get "/" do
  erb :index
end


#get "/pos?:lat,:lon" do

#//DATABASE////////
