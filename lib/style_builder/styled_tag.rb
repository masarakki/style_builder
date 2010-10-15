module StyleBuilder
  class StyledTag
    attr_reader :controller, :method, :args
    
    def style
      @css_style
    end
    
    def initialize(controller, method, *args)
      @controller = controller
      @method = method
      @args = args
      @css_style ||= CssStyle.new
    end
    
    def method_missing(method_name, *method_args, &block)
      style.send(method_name, *method_args)
      if block_given?
        controller.send(method, args.first, :style => style.to_style, &block)
      else
        self
      end
    end
    
    def to_s
      case method
      when :_orig_content_tag
        name, str, options = args
        if style.present?
          options ||= {}
          options[:style] = style.to_style
        end
        controller.send(:_orig_content_tag, name, str, options)
      when :_orig_tag
        puts 'tag'
      end
    end
  end
end
