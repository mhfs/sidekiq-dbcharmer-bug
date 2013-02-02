# Sidekiq DB Charmer Bug #30

Reproduces the bug discussed at https://github.com/kovyrin/db-charmer/issues/30

## Setting up

Clone the repo:

```
git clone git@github.com:mhfs/sidekiq-dbcharmer-bug.git
```

Bundle the gems:

```
bundle
```

## Failing scenario

```
sidekiq -r ./sidekiq-dbcharmer-bug.rb
```

You should see the errors in the terminal.


## Without concurency

If you eliminate concurrency by using just 1 sidekiq worker everything is fine

```
sidekiq -r ./sidekiq-dbcharmer-bug.rb -c 1
```
