require 'rubygems'
require 'sinatra/base'
class HelloApp < Sinatra::Base
  get '/hello' do
    'Good Sunday Morning!'
  end
end
run HelloApp
