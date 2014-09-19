require 'sinatra/base'
require 'sinatra/json'
require_relative 'model'
require 'pp'

module Joogle
    class App < Sinatra::Base
        get '/' do
            html :index
        end

        ### API
        get '/api/test' do
            res = {
                packages: [
                    {
                        name: "twitter4j",
                        reference: "http://twitter4j.org/javadoc/",
                    },
                    {
                        name: "Processing",
                        reference: "http://processing.org/reference/javadoc/core/",
                    },
                ],
                methods: [
                    {
                        name: "background",
                        params: [
                            {
                                name: "rgb",
                                type: "int",
                            }
                        ],
                        out: "float",
                        javadoc_name: "Processing",
                        reference: "http://processing.org/reference/javadoc/core/processing/core/PGraphics.html%23brightness(int)",
                        description: "( begin auto-generated from brightness.xml ) Extracts the brightness value from a color. ( end auto-generated )",
                        belong_to: {
                            package: "processing.core",
                            name: "processing.core.PGraphics",
                            simple_name: "PGraphics",
                            type: "Class",
                        }
                    }
                ],
            }
            headers "Access-Control-Allow-Origin" => "*"
            json res
        end

        get '/api/jdoc' do
            jdoc = Javadoc.all
            headers "Access-Control-Allow-Origin" => "*"
            json jdoc
        end

        get '/api/search' do
            halt 400 if params['query'].nil?
            q = parse_query params['query']
            if(q[:out].nil?)
                q[:out] = "void"
            end

            method = Joogle::Method
            method = method.where(Sequel.ilike(:belong_to, "%.#{q[:type]}")) if q[:type]
            method = method.where(Sequel.ilike(:out, /(#{query_alias(q[:out])})$/))
            if !q[:params].empty?
                q[:params].map! do |param|
                    query_alias(param)
                end
                query = "^" + q[:params].map { |param| "(#{param}) [a-zA-Z]+" }.join(", ") + "$"
                method = method.where(Sequel.ilike(:params, /#{query}/))
            end

            data = {}
            data['methods'] = []
            data['packages'] = []
            method.all.each do |m|
                data['methods'] << m.to_hash
                if(!data['packages'].include? m.javadoc.to_hash)
                    data['packages'] << m.javadoc.to_hash
                end
            end

            json data
        end

        helpers do
            def query_alias(query)
                if query.downcase == "number"
                    "int|float|long|double|short"
                elsif query.downcase == "number[]"
                    "(int|float|long|double|short)\\[\\]"
                elsif query.downcase == "primitive"
                    "int|float|long|double|short|char|boolean|byte"
                elsif query.downcase == "primitive[]"
                    "(int|float|long|double|short|char|boolean|byte)\\[\\]"
                else
                    query
                end
            end

            def html(view)
                File.read(File.join('public', "#{view.to_s}.html"))
            end

            def parse_query(text)
                if res = text.match(/\s*(?:(?<type>(?:\w|\[|\]|<|>|\.)+)\s*:)?(?<params>(?:\s*(?:\w|\[|\]|<|>|\.)+)*)\s*(?:->\s*(?<out>(?:\w|\[|\]|<|>|\.)+))?\s*/)
                    query = {}
                    query[:type] = res[:type]
                    query[:params] = res[:params].gsub(/\s+/, ' ').split
                    query[:out] = res[:out]
                    return query
                end

                return nil
            end
        end
    end
end
