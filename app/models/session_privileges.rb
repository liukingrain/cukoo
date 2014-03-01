class SessionPrivileges
  ATTRIBUTES = [:order_auth_tokens]
  
  attr_accessor :storage
  attr_accessor *ATTRIBUTES
  
  def initialize(storage)
    self.storage = storage
  end
  
  ATTRIBUTES.each do |attribute|
    define_method attribute do
      instance_variable_set("@#{attribute}", storage[attribute] || []) if instance_variable_get("@#{attribute}").nil?
      instance_variable_get("@#{attribute}")
    end
  end
    
  def store!
    ATTRIBUTES.each do |attribute|
      storage[attribute] = send(attribute)
    end
  end
end
