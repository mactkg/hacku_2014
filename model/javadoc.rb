require 'sequel'

#Sequel::Model.plugin(:schema)
module Joogle
    class Javadoc < Sequel::Model(:javadoc)
        plugin :json_serializer
    end
end
