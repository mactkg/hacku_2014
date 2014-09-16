require 'sinatra/base'

class Joogle < Sinatra::Base
    get '/' do
      '{"message": "hello, world"}'
    end
end
