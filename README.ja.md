# Rounders [![Build Status](https://travis-ci.org/rike422/rounders.svg?branch=master)](https://travis-ci.org/rike422/rounders)  [![Code Climate](https://codeclimate.com/github/rike422/rounders/badges/gpa.svg)](https://codeclimate.com/github/rike422/rounders) [![Coverage Status](https://coveralls.io/repos/github/rike422/rounders/badge.svg?branch=master)](https://coveralls.io/github/rike422/rounders?branch=master)

Roundersは拡張性を重視した、メール処理フレームワークです。
RubotyなどのBotを参考に作られました。


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

### botの作成

botを作成するには、下記のコマンドを実行します。

```
rounders new [name]
```

### メールアカウントの設定

生成されたbotの`config/initiarizers/mail.rb`にメールアカウント情報を設定します。
```
Rounders::Receivers::Mail.configure do |config|
  # please show more option
  #
  config.protocol = :imap
  # メールアカウント情報を設定します。
  config.mail_server_setting = {
    address:    'imap.gmail.com',
    port:       993,
    user_name:  ENV['GMAIL_USER_NAME'],
    password:   ENV['GMAIL_PASSWORD'],
    enable_ssl: true
  }
  config.options = {
    # flag for whether to delete each receive mail after find Default: false
    # delete_after_find: true
  }
end

```

### botの実行

`bundle exec rounders start`でbotをスタートできます。

## Modules

Roundersはそれぞれのモジュールの基底クラスを継承することにより、
Hookが行われ、システム内に組み込むことができます。

各モジュールのテンプレートを作成するジェネレータを用意しています。

#### Handlers

Handlersはメールのハンドングを行うモジュールです。
`.on`の第一引数で渡した条件で下記のMatcherインスタンスを作成し、
マッチしたメールを、第二引数で渡したメソッドに引き渡します

#### Generate Command

下記のように`rounders generate handler`をroudersディレクトリ内で実行することで、
./app/handlersの中にテンプレートファイルが生成されます。

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
      # body include 'exmpale' AND subject match the /programing (?<name>.+)$/
      on({ 
		  body: 'example',
		  subject: /programing (?<name>.+)$/},
		  :callback_method2)
​
      def method1(mail)
        # BodyMatcherの戻り値画が格納されています。
        matches[:body]
        # => #<MatchData "example">
       	# 引数のmail、matchesを利用して処理を行えます。
      end
​
      def method2(mail)
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

Matcherはメールのフィルタリングを行うモジュールです。
`#match`メソッドを実装する必要があり、このメソッドが返した値は、
Handlersメソッド内で扱えるmatchesに格納されます。

#### Generate Command

下記のように`rounders generate matchers`をroudersディレクトリ内で実行することで、
./app/matchers/の中にテンプレートファイルが生成されます。

```
rounders generate matchers [name]`
```

下記はHTMLメールに対して、CSSセレクタでフィルタ・抽出を行うためのMatcherの実装例です。

#### exmaple

/app/matchers/css_selector.rb

```ruby
module Rounders
  module Matchers
    # クラス名をsnake_caseにした値が、handlerでのkeyになります。
    class CssSelector < Rounders::Matchers::Matcher
      attr_reader :pattern

      def initialize(pattern)
        @pattern = pattern
      end

      def match(mail)
        return if mail.html_part.blank?
        html_part = Nokogiri::HTML(mail.html_part.body.to_s)
        node = html_part.css(pattern)
        # 戻り値がmatches[:css_selector]に格納されます。
        node.present? ? node : nil
      end
    end
  end
end

```

/app/handlers/your_hander.rb
```ruby
module Rounders
  module Handlers
    class YourHandler < Rounders::Handlers::Handler
      # 上記のCssSelectorを利用するためにキーを指定して、CSSセレクタを値として渡します。
      on({ css_selector: 'body .header h2' }, method1)
		  
      def method1(mail)
        # CssSelectorの戻り値が格納されています。
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

RoundersのモジュールはGemとして配布できます。
上記のCssSelectorをGemにしたものが下記のリポジトリになります。
- [rounders-css_selector_matcher](https://github.com/rike422/rounders-css_selector_matcher)

#### reciever

coming soon...


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

