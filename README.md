# FastEntry
Cache management for Rails applications.

> There are only two hard things in Computer Science: cache invalidation and naming things.
> -- Phil Karlton

FastEntry helps with the first. It comes with a web interface that can display the current state of your cache usage. Use it to view cache keys, inspect details or invalidate cached information.

![](https://user-images.githubusercontent.com/407470/52439845-d8ecff80-2b1c-11e9-8cdb-8c2323585583.png)

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'fastentry'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install fastentry
```

Add the following to your `config/routes.rb`:

```ruby
require "fastentry/engine"
mount Fastentry::Engine, at: "/fastentry"
```

#### Authentication

If you'd like to restrict access to this interface you can use constraints on your routes. Here's an example using Devise to authenticate an `Admin` before getting access to FastEntry:

```ruby
require "fastentry/engine"
authenticate :admin do
  mount Fastentry::Engine, at: "/fastentry"
end
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Author
Tiago Alves, @alvesjtiago, tiago @ rebase.studio