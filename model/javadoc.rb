require 'sequel'

module Joogle
    class Javadoc < Sequel::Model(:javadoc)
        plugin :json_serializer
    end
end
