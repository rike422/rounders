# Rounders [![Gem Version](https://badge.fury.io/rb/rounders.svg)](https://badge.fury.io/rb/rounders) [![Build Status](https://travis-ci.org/rike422/rounders.svg?branch=master)](https://travis-ci.org/rike422/rounders)  [![Code Climate](https://codeclimate.com/github/rike422/rounders/badges/gpa.svg)](https://codeclimate.com/github/rike422/rounders) [![Coverage Status](https://coveralls.io/repos/github/rike422/rounders/badge.svg?branch=master)](https://coveralls.io/github/rike422/rounders?branch=master)

[日本語README](https://github.com/rike422/rounders/blob/master/README.ja.md)

Rounders is a mail handling framework that emphasizes pluggability.
 It was made with reference to Bot such as [Ruboty](https://github.com/r7kamura/ruboty),[Lita](https://github.com/litaio/lita).

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

To create a bot, execute the following command.

```
rounders new [name]
```

### Mail account settings

Set mail account information in `bot/config/initiarizers/ mail.rb` of the generated bot.

```
Rounders::Receivers::Mail.configure do |config|
  # please show more option
  #
  config.protocol = :imap
  # メールアカウント情報を設定します。
  config.mail_server_setting = {
    address:    'imap.gmail.com',
    port:       993,
    user_name:  ENV['USER_NAME'],
    password:   ENV['PASSWORD'],
    enable_ssl: true
  }
  config.options = {
    # flag for whether to delete each receive mail after find Default: false
    # delete_after_find: true
  }
end

```

### start bot

You can start the bot with `bundle exec rounders start`.

### Modules


If you want to extend the processing of Rounders. inherit the base class of following modules.
it is hooked and can be incorporated into the Rounders.

#### Handlers

Handlers is a module that handles mails.
Create the Matcher instance with the condition passed as the first argument of `.on`,
If there is a matching email, If there is a matching email, It passe to the method that passed as the second argument

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
      on({ body: 'example' }, :method1)
      # body include 'exmpale' AND subject match the /programing (?<name>.+)$/
      on({ 
        body: 'example',
        subject: /programing (?<name>.+)$/},
        :method2)
​
      def method1(mail, matches)
       # The return value of BodyMatcher is assign to Handler#matches.
        matches[:body]
        # => #<MatchData "example">
       	# any process
      end
​
      def method2(mail, matches)
        matches[:subject]
      	# => <MatchData "programing ruby" name:"ruby">
      	matches[:subject][:name]
      	# => "ruby"
      end
    end
  end
end

```

#### Matchers 

Matcher is a module that performs mail filtering.
The Matcher must implement 'match' method, and the value returned by this method which returns value assign to Handler#matches

The `rounders generate matchers` command create template of matchers into ./plugins/matchers/

```
rounders generate matchers [name]`
```


Below is an example of Matcher for filtering / extracting with CSSSelector for HTML mail.

#### exmaple

/plugins/matchers/css_selector.rb

```ruby
module Rounders
  module Matchers
    class CssSelector < Rounders::Matchers::Matcher
      attr_reader :pattern

      def initialize(pattern)
        @pattern = pattern
      end

      def match(mail)
        return if mail.html_part.blank?
        html_part = Nokogiri::HTML(mail.html_part.body.to_s)
        node = html_part.css(pattern)
        node.present? ? node : nil
      end
    end
  end
end

```

/plugins/handlers/your_hander.rb
```ruby
module Rounders
  module Handlers
    class YourHandler < Rounders::Handlers::Handler
      # css selector match 
      on({ css_selector: 'body .header h2' }, :method1)
		  
      def method1(mail)
        matches[:css_selector]
        # =>[#<Nokogiri::XML::Element:0x3fc6d77f6ccc name="h2" children=[#<Nokogiri::XML::Text:0x3fc6d77f6ad8 " head text ">]>]
        matches[:css_selector].to_s
        # => '<h2> head text </h2>'
      end
    end
  end
end

```

#### Gems

Rounder's module can be distributed as Gem.

- [rounders-css_selector_matcher](https://github.com/rike422/rounders-css_selector_matcher)

### Store

Store is module that application memory.
It can record data like a Hash object.
ex: `rounders.sotre[{key}] = {value}`

##### example

```ruby
module Rounders
  module Handlers
    class MyHandler < Rounders::Handlers::Handler
      # mail.body is include 'exmpale'
      on({ body: 'example' }, :method1)
​
      def method1(mail, matches)
        # initialize :data memory
        count = rounders.store[:access] || 0
	
        count += 1
        Rounders.logger.info count
        # log access count
        rounders.store[:access] = count
      end
    end
  end
end
```

#### Gems

- [rounders-yaml](https://github.com/rike422/rounders-yaml)

#### reciever

coming soon...

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rounders. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

