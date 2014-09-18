require 'yaml'
require 'mysql2'

namespace :db do
    desc "setup"
    task :migrate do
        system "bundle exec sequel -m db/migration -e development config/database.yml -E"
    end

    desc "drop db"
    task :drop do
        config = YAML.load_file('config/database.yml')['development']
        client = Mysql2::Client.new(:host => "localhost", :username => config['user'], :password => config['password'])
        client.query "DROP DATABASE IF EXISTS `#{config['database']}`"
    end

    desc "create db"
    task :create do
        config = YAML.load_file('config/database.yml')['development']
        client = Mysql2::Client.new(:host => "localhost", :username => config['user'], :password => config['password'])
        client.query "CREATE DATABASE `#{config['database']}`"
    end
end
