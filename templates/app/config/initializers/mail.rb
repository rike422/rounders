Kiki::Receiver.configure do |config|
  # please show more option
  #
  config.protocol = :pop3
  config.mail_server_settings = {
    address:    'pop.gmail.com',
    port:       995,
    user_name:  ENV['GMAIL_USER_NAME'],
    password:   ENV['GMAIL_PASSWORD'],
    enable_ssl: true
  }
end
