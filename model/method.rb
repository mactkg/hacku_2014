require 'sequel'

#Sequel::Model.plugin(:schema)
module Joogle
    class Method < Sequel::Model(:method)
        plugin :json_serializer
    end
end
