require "sinatra"
require "sinatra/reloader" if development?
require "json"

require 'date'
set :port, 3000
set :bind, '0.0.0.0'

get "/" do
  erb :index
end

post "/getStationData" do
  #AJAX-js <=> POST station petition
  if(params[:station_id])
    id = params[:station_id]
  else
    lat = params[:latitude]
    lon = params[:longitude]
  end
  #Return station object whit all the info
end
