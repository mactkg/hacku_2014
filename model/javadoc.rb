require 'sequel'
require_relative 'method'

module Joogle
    class Javadoc < Sequel::Model(:javadoc)
        plugin :json_serializer
        one_to_many :method, :class => "Joogle::Method"
    end
end
