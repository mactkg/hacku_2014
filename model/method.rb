require 'sequel'
require 'uri'
require_relative 'javadoc'

#Sequel::Model.plugin(:schema)
module Joogle
    class Method < Sequel::Model(:method)
        #plugin :json_serializer
        many_to_one :javadoc, :class => "Joogle::Javadoc"
        def to_hash
            params_json = [];
            params.split(',').each do |param|
                vk = param.split(' ')
                params_json << {vk[1] => vk[0]}
            end
            {
                name: name,
                params: params_json,
                out: out,
                javadoc_name: javadoc.name,
                reference: URI.unescape(permalink),
                description: description,
                belong_to: {
                    name: belong_to,
                    package: package,
                    simple_name: simple_name,
                    type: type,
                },
            }
        end

        def package
            return belong_to.split(' ')[1].split('.').select{|s| s =~ /^[a-z]/}.join('.')
        end

        def simple_name
            return belong_to.split(' ')[1].split(',').last
        end

        def type
            return belong_to.split(' ')[0]
        end
    end
end
