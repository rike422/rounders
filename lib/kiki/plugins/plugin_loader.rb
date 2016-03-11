module Kiki
  module Plugins
    class PluginLoader
      class << self
        def register(klass)
          pluggable_classes << klass
        end

        def load_plugins
          pluggable_classes.each(&:load_plugins)
        end

        private

        def pluggable_classes
          @_pluggable_classes ||= []
        end
      end
    end
  end
end
