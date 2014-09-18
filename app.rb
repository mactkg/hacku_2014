require 'sinatra/base'
require 'sinatra/json'
require_relative 'model'
require 'pp'

class Joogle < Sinatra::Base
    get '/' do
        "Welcome to joogle!"
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
        jdoc.to_json
    end

    get '/api/search' do
        params.to_json
    end
end
