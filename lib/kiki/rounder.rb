module Kiki
  class Rounder
    DEFAULT_INTERVAL = 100
    def start
      polling
    end

    private

    def polling
      loop do
        round
        sleep interval
      end
    end

    def round
      handle receive_mail
    end

    def handle(mails)
      Handler.handlers.map { |handler| handler.dispatch(self, mails) }
    end

    def receive_mail
      Kiki::Receiver.receive
    end

    def interval
      DEFAULT_INTERVAL
    end
  end
end
