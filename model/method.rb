require 'sequel'
require 'uri'
require_relative 'javadoc'

#Sequel::Model.plugin(:schema)
module Joogle
    class Method < Sequel::Model(:method)
        #plugin :json_serializer
        plugin :force_encoding, 'UTF-8'
        many_to_one :javadoc, :class => "Joogle::Javadoc"
        def to_hash
            params_json = [];
            params.split(',').each do |param|
                vk = param.split(' ')
                params_json << {type: vk[0], name: vk[1]}
            end
            {
                name: name,
                params: params_json,
                out: out,
                javadoc_name: javadoc.name,
                reference: URI.unescape(permalink),
                description: description,
                belong_to: {
                    name: package_name,
                    package: package,
                    simple_name: simple_name,
                    type: type,
                },
                sample_code: sample_code,
            }
        end

        def package
            return package_name.split('.').select{|s| s =~ /^[a-z]/}.join('.')
        end

        def simple_name
            return package_name.split('.').last
        end

        def package_name
            return belong_to.split(' ')[1]
        end

        def type
            return belong_to.split(' ')[0]
        end
    end
end
