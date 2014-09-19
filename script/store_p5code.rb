# coding: utf-8
require 'sequel'
require_relative '../model.rb'
require_relative 'p5_parser'

puts "Start parsing p5 doc"

p = parse

puts "Done parsing"

javadoc = Joogle::Javadoc.find(:name => "processing")

puts "Inserting!"

p.each do |func|
    target = Joogle::Method
    target = target.where(:name => func['name'])
    target = target.where(Sequel.ilike(:belong_to, /#{func['belong_to']}$/))
    target.all.each do |m|
        m.update(:sample_code => func['sample_code'])
        puts m.name
        puts func['sample_code']
    end
end
