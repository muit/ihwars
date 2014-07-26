require "sinatra"
require "sinatra/reloader" if development?
require "json"

require_relative "lib/db.rb"
require_relative "lib/parser.rb"

set :port, 3000
set :bind, '0.0.0.0'

get "/" do
  erb :index
end

post "/getStationData" do
  db = DBRetriever.new(DBAdaptorFake)
  #AJAX-js <=> POST station petition
  id = params[:station_id]
  name = params[:station_name]

  if id != nil
    station = db.get.StationById(id)
    return JSON.stringify(station)
  end
  if name != nil
    station = db.get.StationByName(name)
    return JSON.stringify(station)
  end
  
  "404 ERROR: Data provided corrupted"
end

post "/getNearStations" do
  lat = params[:latitude]
  lon = params[:longitude]

  JSON.stringify([])
end