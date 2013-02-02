$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sidekiq-failures-example'
require 'sidekiq/web'

GoodWorker.perform_async('good')
GoodWorker.perform_async('good')
GoodWorker.perform_async('good')

BadWorker.perform_async('bad')
BadWorker.perform_async('bad')

run Sidekiq::Web
