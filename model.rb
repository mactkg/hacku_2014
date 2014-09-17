require 'sequel'

Sequel::Model.plugin(:schema)
DB = Sequel.connect(:adapter=>'mysql2', :host=>'localhost', :database=>'hacku2014', :user=>'hacku', :password=>'hacku2014')

require_relative 'model/javadoc'
require_relative 'model/method'
