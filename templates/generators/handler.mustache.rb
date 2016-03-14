module Kiki
  module Handlers
    class {{ class_name }} < Kiki::Handlers::Handler
    {{#handlers}}
      on({ body: 'example' }, :{{.}})
    {{/handlers}}
    {{#handlers}}

      def {{.}}(mail)
      end
    {{/handlers}}
    end
  end
end
