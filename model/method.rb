require 'sequel'

#Sequel::Model.plugin(:schema)
module Joogle
    class Mehtod < Sequel::Model(:method)
        plugin :json_serializer
    end
end
