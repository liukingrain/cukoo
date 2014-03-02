# encodinng: utf-8
class SearchResultDecorator < Draper::Decorator
  RESULT_TYPES = %w(Product)
  
  delegate_all
  delegate :name, :description, :product_type, :size, to: :result_decorator
  
  def to_model
    object
  end
  
  private
  
  def result_decorator
    if object.class.name.in?(RESULT_TYPES)
      "#{object.class.name}SearchResultDecorator".constantize.decorate(object)
    end
  end
end
