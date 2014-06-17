require 'sinatra'
require 'sinatra/reloader'
require 'spreadsheet'

configure do
  enable :sessions
end
get '/' do
	erb :"index"
end	