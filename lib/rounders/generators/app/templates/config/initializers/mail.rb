Rounders::Receivers::Mail.configure do |config|
  # please show more option
  #
  config.protocol = :imap
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
