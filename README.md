# Sidekiq Failures Example

This is a very simple demo of [sidekiq](github.com/mperham/sidekiq) and [sidekiq-failures](https://github.com/mhfs/sidekiq-failures).

## Running

Clone the repo:

```
git clone git@github.com:mhfs/sidekiq-failures-example.git
```

Bundle the gems:

```
bundle
```

Run sidekiq-web:

```
rackup
```

Access `http://localhost:9292/`. You'll see 5 enqueued jobs. 3 GoodWorkers and 2 BadWorkers. You're Failures tab should be empty.

It's time to consume them:

```
sidekiq -r ./sidekiq-failures-example.rb
```

Refresh your browser and you should now see failures appearing as the BadWorkers are failing and being retried.