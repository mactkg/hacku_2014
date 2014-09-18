require 'sequel'

module Joogle
    class ParsingQueue < Sequel::Model(:parsing_queue)
        plugin :json_serializer
    end
end
