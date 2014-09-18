require 'sequel'
require 'javadoc'
require_relative '../model.rb'

pending = Joogle::ParsingQueue.where(:status => "pending").first

puts "Start parsing javadoc: #{pending.url}"

parser = Javadoc::Parser.new(pending.url)
parser.parse

puts "Done parsing"

name = parser.classes.first.package.name.split(".").first
javadoc = Joogle::Javadoc.create(:name => name, :simple_name => name, :url => pending.url)

puts "Inserting!"

parser.classes.each do |c|
    c.methods.each do |m|
        params = m.params.map! { |p| p.join(" ") }.join(', ')
        method = Joogle::Method.create(
            :name => m.name,
            :belong_to => "#{c.type} #{c.package.name}.#{c.name.children.text}",
            :params => params,
            :out => m.return,
            :description => m.description,
            :permalink => m.reference
        )
        javadoc.add_method(method)
        puts m.name
    end
end

pending.update(:status => "finished")
