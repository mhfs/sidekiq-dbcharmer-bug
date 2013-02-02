require "sidekiq"
require "active_record"

##
# Setup AR and establish connection
ActiveRecord::Base.logger = Logger.new('debug.log')
ActiveRecord::Base.configurations = YAML::load(IO.read('./database.yml'))
ActiveRecord::Base.establish_connection('development')

##
# Create empty user table and model
class CreateUserSchema < ActiveRecord::Migration
  def change
    create_table :users, force: true do |t|
      t.string :name
    end

    add_index :users, :name
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
10.times  { User.create!(name: "Marcelo") }
250.times { HardWorker.perform_async('good') }
