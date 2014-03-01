class CartSteps::Base
  include ActiveModel::Validations
  include ActiveModel::ForbiddenAttributesProtection
  
  attr_reader :collection
  
  delegate :cart, to: :collection
  delegate :reload, to: :cart
    
  def initialize(collection)
    @collection = collection
  end

  def to_param
    self.class.to_s.gsub("CartSteps::", "").underscore
  end
  
  def next
    @next ||= collection.next_step(to_param)
  end
  
  def previous
    @previous ||= collection.previous_step(to_param)
  end
  
  def required?
    true
  end
  
  def accessible?
    return true if previous.nil?
    previous.accessible? && previous.valid?
  end
  
  def update_attributes(values, options = {})
    unless values.nil?
      sanitize_for_mass_assignment(values).each do |k, v|
        send("#{k}=", v)
      end
    end
    save
  end
  
  def save
    return cart.save(validate: false) if valid?
    false
  end
  
  def save!
    return cart.save!(validate: false) if valid?
    raise
  end
  
  def to_key
    [to_param]
  end
  
  def self.model_name
    ActiveModel::Name.new(self, nil, "CartStep")
  end
  
  def persisted?
    true
  end
  
  def new_record?
    !persisted?
  end
  
  def ==(value)
    if value.is_a?(CartSteps::Base)
      self.to_param == value.to_param
    elsif value.is_a?(String)
      self.to_param == value
    else
      super
    end
  end
end
