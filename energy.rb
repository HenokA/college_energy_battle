require 'sinatra'
require 'sinatra/reloader'


configure do
  enable :sessions
end

get '/' do
	erb :"index"
end	