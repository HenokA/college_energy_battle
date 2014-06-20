require 'sinatra'
require 'sinatra/reloader'


configure do
  enable :sessions
end

get '/' do
	erb :"index"
end	

get '/about' do
	erb :"about"
end

get '/leaderboard' do
	erb :"leaderboard"
end