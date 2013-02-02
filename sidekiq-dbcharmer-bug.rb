require "sidekiq"
require "active_record"
require "db_charmer"

##
# Setup AR and establish connection
ActiveRecord::Base.logger = Logger.new('debug.log')
ActiveRecord::Base.configurations = YAML::load(IO.read('./database.yml'))
ActiveRecord::Base.establish_connection('development')

##
# Create empty user table and model
class CreateUserSchema < ActiveRecord::Migration
  db_magic connections: [:default, :slave1, :slave2, :slave3]

  def change
    [:default, :slave1, :slave2, :slave3].each do |db|
      on_db db do
        create_table :users, force: true do |t|
          t.string :name
        end
      end
    end
  end
end
CreateUserSchema.new.change

class User < ActiveRecord::Base
end

##
# Define our worker
class HardWorker
  include Sidekiq::Worker

  def perform(name)
    User.find(rand(1..10))
  end
end

##
# Flush sidekiq redis db to avoid outside interference
Sidekiq.redis { |conn| conn.flushdb }

##
# Create a bunch of users and sidekiq jobs
User.on_master do
  10.times  { User.create!(name: "Marcelo") }
end

3.times do |n|
  User.on_db("slave#{n+1}") do
    10.times  { User.create!(name: "Marcelo") }
  end
end

250.times { HardWorker.perform_async('good') }
