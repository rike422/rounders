module Rounders
  module Handlers
    class {{ class_name }} < Rounders::Handlers::Handler
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
