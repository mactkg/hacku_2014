require 'sequel'

Sequel::Model.plugin(:schema)
DB = Sequel.connect(:adapter=>'mysql2', :host=>'localhost', :database=>'hacku2014', :user=>'hacku', :password=>'hacku2014', :encoding => "utf8")

require_relative 'model/javadoc'
require_relative 'model/method'
require_relative 'model/parsing_queue'
