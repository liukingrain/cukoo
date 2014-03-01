class CartSteps::Collection
  STEPS = %w(fresh authentication shipping_and_payment confirmation)

  delegate :each, :each_with_index, to: :steps
    
  attr_reader :cart
  
  def initialize(cart)
    @cart = cart
  end
  
  def find(name)
    steps.find do |step|
      step.is_a?(step_class(name))
    end or raise ActiveRecord::RecordNotFound
  end
  
  def next_step(name)
    index = step_index(name)
    steps[index + 1]
  end
  
  def previous_step(name)
    index = step_index(name)
    steps[index - 1] unless index <= 0
  end
  
  private
  
  def steps
    @steps ||= STEPS.map{ |step| step_class(step).new(self) }.select(&:required?)
  end
  
  def step_class(name)
    "CartSteps::#{name.classify}".constantize
  end
  
  def step_index(name)
    steps.index do |step|
      step.is_a?(step_class(name))
    end
  end
end
