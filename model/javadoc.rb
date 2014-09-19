require 'sequel'
require_relative 'method'

module Joogle
    class Javadoc < Sequel::Model(:javadoc)
        plugin :json_serializer
        plugin :force_encoding, 'UTF-8'
        one_to_many :method, :class => "Joogle::Method"
    end
end
