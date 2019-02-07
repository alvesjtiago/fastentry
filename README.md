# FastEntry
Cache management for Rails applications.

FastEntry comes with a web application that can display the current state of your cache usage. Use it to view cache keys, inspect details or invalidate cached information.

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
require 'fastentry/engine'
mount Fastentry::Engine, at: "/fastentry"
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Author
Tiago Alves, @alvesjtiago, tiago @ rebase.studio