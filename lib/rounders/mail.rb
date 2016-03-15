module Kiki
  class Mail
    extend Forwardable
    def_delegators :@mail,
                   :body,
                   :cc,
                   :envelope_from,
                   :from,
                   :date,
                   :sender,
                   :subject,
                   :to

    def initialize(mail)
      @mail = mail
    end
  end
end
