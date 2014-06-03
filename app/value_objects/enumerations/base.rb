class Enumerations::Base
  module Mount
    def mount_enumeration(column, enumeration, options = {})
      options[:validate] = true if options[:validate].nil?
      attribute = options[:store_attribute] || column
      
      before_save :"write_#{column}_identifier"
      before_validation :"set_default_#{column}" if options[:default]
      before_create :"set_default_#{column}" if options[:default]
      
      validates column, inclusion: { in: enumeration } if options[:validate]

      if options[:store_attribute].blank?
        class_eval <<-RUBY
          def read_#{column}_enumeration
            read_attribute(:#{column})
          end

          def write_#{column}_enumeration(value)
            write_attribute(:#{column}, value)
          end
        RUBY
      else
        class_eval <<-RUBY
          def read_#{column}_enumeration
            read_store_attribute(:#{attribute}, :#{column})
          end

          def write_#{column}_enumeration(value)
            write_store_attribute(:#{attribute}, :#{column}, value)
          end
        RUBY
      end

      class_eval <<-RUBY
        def #{column}
          @#{column} ||= #{enumeration.to_s}.new(self, :#{column})
        end
        
        def #{column}=(value)
          #{attribute}_will_change! if value != #{column}
          #{column}.value = value
        end
        
        private
        
        def write_#{column}_identifier
          #{column}.write_identifier
        end
        
        def set_default_#{column}
          #{column}.value ||= '#{options[:default]}'
        end
        
      RUBY
    end
  end

  attr_reader :model, :column
  attr_accessor :value
  
  def self.options
    @options ||= %w()
  end
  
  def self.include?(option)
    value = option.respond_to?(:value) ? option.value : option
    options.include?(value)
  end
  
  def value=(v)
    value = v.is_a?(Enumerations::Base) ? v.value : v
    @value = option_is_integer? ? value.to_i : value
  end
  
  def initialize(model, column)
    @model = model
    @column = column
    
    read_identifier
  end
  
  def to_s
    humanize(value)
  end
  
  def ==(other)
    if other.is_a?(option_class)
      value == other
    elsif other.is_a?(Symbol)
      value == other.to_s
    else
      super
    end
  end
  
  def options
    self.class.options
  end
  
  def select_options
    @select_options ||= options.map{ |o| [humanize(o), o] }
  end
  
  def read_identifier
    @value = model.send("read_#{column}_enumeration")
  end

  def write_identifier
    model.send("write_#{column}_enumeration", value)
  end
  
  private
  
  def humanize(option)
    I18n.t("enumerations.#{model.class.model_name.singular}.#{column}.#{option}")
  end
  
  def option_class
    self.class.options.first.class
  end
  
  def option_is_integer?
    self.class.options.first.is_a?(Integer)
  end
end

ActiveRecord::Base.extend(Enumerations::Base::Mount)
