# Kiki [![Circle CI](https://circleci.com/gh/rike422/kiki.svg?style=svg)](https://circleci.com/gh/rike422/kiki)  [![Code Climate](https://codeclimate.com/github/rike422/kiki/badges/gpa.svg)](https://codeclimate.com/github/rike422/kiki)

The pluggalbe mail processing framework

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kiki'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kiki

## Usage

### create bot

create a new bot by running the kiki new command after installing kiki.

```
kiki new [name]
```

### generator

#### handler

The `kiki generate handler` command create template of handler into ./plugins/handlers/

```
kiki generate handler [name] [method1, method2...] `
```
##### example

```ruby
module Kiki
  module Handlers
    class MyHandler < Kiki::Handlers::Handler
      # mail.body is include 'exmpale'
      on({ body: 'example' }, :callback_method1)
      # body include 'exmpale' AND subject include 'my_subject'
      on({ 
		  body: 'example',
		  subject: /my_subject/},
		  :callback_method2)
​
      def method1(mail)
        // any process
      end
​
      def method2(mail)
         // any process
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

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/kiki. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

