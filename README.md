# Rounders [![Circle CI](https://circleci.com/gh/rike422/rounders.svg?style=svg)](https://circleci.com/gh/rike422/rounders)  [![Code Climate](https://codeclimate.com/github/rike422/rounders/badges/gpa.svg)](https://codeclimate.com/github/rike422/rounders) [![Coverage Status](https://coveralls.io/repos/github/rike422/rounders/badge.svg?branch=master)](https://coveralls.io/github/rike422/rounders?branch=master)

The pluggalbe mail processing framework

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rounders'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rounders

## Usage

### create bot

create a new bot by running the rounders new command after installing rounders.

```
rounders new [name]
```

### generator

#### handler

The `rounders generate handler` command create template of handler into ./plugins/handlers/

```
rounders generate handler [name] [method1, method2...] `
```
##### example

```ruby
module Rounders
  module Handlers
    class MyHandler < Rounders::Handlers::Handler
      # mail.body is include 'exmpale'
      on({ body: 'example' }, :callback_method1)
      # body include 'exmpale' AND subject include 'my_subject'
      on({ 
		  body: 'example',
		  subject: /my_subject/},
		  :callback_method2)
​
      def method1(mail)
       	# any process
      end
​
      def method2(mail)
        # any process
      end
    end
  end
end

```

#### matcher 

coming soon...

#### reciever

coming soon...

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rounders. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

