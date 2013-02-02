# Sidekiq DB Charmer Bug #30

Reproduces the bug dicussed at https://github.com/kovyrin/db-charmer/issues/30

## Running

Clone the repo:

```
git clone git@github.com:mhfs/sidekiq-dbcharmer-bug.git
```

Bundle the gems:

```
bundle
```

```
sidekiq -r ./sidekiq-dbcharmer-bug.rb
```

You should see the errors in the terminal.
