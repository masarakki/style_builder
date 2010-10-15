module ActionView
  module Helpers
    module TagHelper
#      alias_method :_orig_tag, :tag
#      def tag(name, options = nil, open = false, escape = true)
#        StyleBuilder::StyledTag.new(self, :_orig_tag, name)
#      end
      
      alias_method :_orig_content_tag, :content_tag
      def content_tag(*args, &block)
        if block_given?
          _orig_content_tag(args, &block)
        else
          StyleBuilder::StyledTag.new(self, :_orig_content_tag, *args)
        end
      end
    end
  end
end
