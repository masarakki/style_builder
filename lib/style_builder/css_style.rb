module StyleBuilder
  class CssStyle
    def initialize
      @styles = {}
    end
    
    def method_missing(name, *args)
      if match = name.to_s.match(/^(.+?)=?$/)
        @styles[$1] = args.first
        self
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
  end
end
