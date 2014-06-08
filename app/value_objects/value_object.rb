class ValueObject
  module Mount
    def value_object(column, value_object, options = {})
      # options[:validate] = true if options[:validate].nil?
      attribute = options[:store_attribute] || column
      source_attribute = options[:on] || column
      
      before_save :"write_#{column}_identifier"
      # before_validation :"set_default_#{column}" if options[:default]
      # before_create :"set_default_#{column}" if options[:default]
      
      # validates column, inclusion: { in: value_object }, allow_blank: options[:allow_blank] if options[:validate]

      if options[:on]
        class_eval <<-RUBY
          def read_#{column}_value_object
            send(:#{source_attribute})
          end

          def write_#{column}_value_object(value)
            send("#{source_attribute}=", value)
          end
        RUBY
      elsif options[:store_attribute].blank?
        class_eval <<-RUBY
          def read_#{column}_value_object
            read_attribute(:#{source_attribute})
          end

          def write_#{column}_value_object(value)
            write_attribute(:#{source_attribute}, value)
          end
        RUBY
      else
        class_eval <<-RUBY
          def read_#{column}_value_object
            read_store_attribute(:#{attribute}, :#{source_attribute})
          end

          def write_#{column}_value_object(value)
            write_store_attribute(:#{attribute}, :#{source_attribute}, value)
          end
        RUBY
      end

      class_eval <<-RUBY
        def #{column}
          @#{column} ||= #{value_object.to_s}.new(self, :#{column}, #{options[:allow_blank]})
        end
        
        def #{column}=(value)
          #{attribute}_will_change! if respond_to?(:#{attribute}_will_change!) && value != #{column}
          #{column}.value = value
        end
        
        private
        
        def write_#{column}_identifier
          #{column}.write_identifier
        end        
      RUBY
    end
  end

  attr_reader :model, :column
  attr_accessor :value
  delegate :blank?, :present?, :==, to: :value
    
  def value=(v)
    value = v.is_a?(self.class) ? v.value : v
    @value = value
  end
  
  def initialize(model, column, allow_blank = false)
    @model = model
    @column = column
    
    read_identifier
  end
  
  def to_s
    humanize(value)
  end
    
  def options
    self.class.options
  end
  
  def read_identifier
    @value = model.send("read_#{column}_value_object")
  end

  def write_identifier
    model.send("write_#{column}_value_object", value)
  end
  
  private
  
  def humanize(option)
    self.inspect
  end  
end

ActiveRecord::Base.extend(ValueObject::Mount)
