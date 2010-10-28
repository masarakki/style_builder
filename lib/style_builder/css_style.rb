module StyleBuilder
  class CssStyle
    def initialize
      @styles = {}
    end
    
    def method_missing(name, *args)
      if match = name.to_s.match(/^(.+?)=?$/)
        self.class.send(:define_method, $1) do |*params|
          params.present? ? _set($1, params.first) : _delete($1)
        end
        self.class.send(:define_method, "#{$1}=") do |param|
          _set($1, param)
        end
        send($1, *args)
      end
    end
    
    def to_style
      @styles.map{|key, value|
        "#{key.to_s.gsub(/_/, '-')}:#{value.to_s}"
      }.join(";")
    end
    
    def present?
      @styles.present?
    end
    
    def inspect
      "style=\"#{to_style}\""
    end
    
    def red
      self.color = '#ff0000'
    end
    
    def center
      self.text_align = 'center'
    end
    
    private
    def _set(key, value)
      @styles[key.to_sym] = value
      self
    end
    
    def _delete(key)
      @styles.delete(key.to_sym)
    end
  end
end
