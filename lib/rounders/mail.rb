module Rounders
  class Mail
    extend Forwardable
    attr_reader :mail
    def_delegators :@mail,
                   :all_parts,
                   :attachment,
                   :attachment?,
                   :attachments,
                   :bcc,
                   :body,
                   :body_encoding,
                   :cc,
                   :charset,
                   :comments,
                   :content_description,
                   :content_id,
                   :content_location,
                   :content_transfer_encoding,
                   :content_type,
                   :date,
                   :decode_body,
                   :decoded,
                   :default,
                   :encoded,
                   :envelope_date,
                   :envelope_from,
                   :filename,
                   :from,
                   :has_attachments?,
                   :header,
                   :headers,
                   :html_part,
                   :in_reply_to,
                   :keywords,
                   :main_type,
                   :message_content_type,
                   :message_id,
                   :mime_parameters,
                   :mime_type,
                   :mime_version,
                   :multipart_report?,
                   :part,
                   :parts,
                   :sender,
                   :sub_type,
                   :subject,
                   :text?,
                   :text_part,
                   :to

    def initialize(mail)
      @mail = mail
    end
  end
end
