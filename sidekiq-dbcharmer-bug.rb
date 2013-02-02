require "sidekiq"
require "sidekiq-failures"

class GoodWorker
  include Sidekiq::Worker

  def perform(name)
    puts 'Doing hard work'
  end
end

class BadWorker
  include Sidekiq::Worker

  def perform(name)
    breaking_the_job # undefined method
  end
end
