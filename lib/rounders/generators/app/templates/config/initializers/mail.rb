Rounders::Receivers::Mail.configure do |config|
  # please show more option
  #
  config.protocol = :imap
  config.mail_server_setting = {
    address:    ENV['IMAP_SERVER_ADDRESS'],
    port:    ENV['IMAP_SERVER_PORT'],
    user_name:  ENV['IMAP_USER_NAME'],
    password:   ENV['IMAP_PASSWORD'],
    enable_ssl: true
  }
  config.options = {
    # flag for whether to delete each receive mail after find Default: false
    # delete_after_find: true
  }
end
