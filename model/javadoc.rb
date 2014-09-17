require 'sequel'

#Sequel::Model.plugin(:schema)
class Javadoc < Sequel::Model(:javadoc)
    plugin :json_serializer
end
