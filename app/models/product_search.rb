class ProductSearch
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  extend Enumerations::Base::Mount
  
  ORDERS = %w(created_at)
  ATTRRIBUTES = %i(q limit fabric color variant_size bargain)
                   
  ATTRRIBUTES.each do |attribute|
    attr_accessor attribute
  end
    
  def initialize(attributes = {})
    attributes ||= {}
    ATTRRIBUTES.each do |attribute|
      send("#{attribute}=", attributes[attribute])
    end
  end
  
  def sphinx_scope
    @sphinx_scope ||= Product.search
  end
  
  def resolve
    filter_by_size
    filter_by_bargain
    #filter_by_type
    #filter_by_fabric
    #filter_by_color
    #filter_with_complex_filters
    search_q_and_paginate
    #order_sphinx_scope
  end
  
  def to_key
    nil
  end
  
  # Wyszukiwanie po nazwie podkategorii.
  def subcategory
    @subcategory ||= begin
      category.children.friendly.find(subcategory_id) unless category.nil?
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end
  
  # Porządek sortowania wyników wyszukiwania. Jeżeli 
  # nie jest określony, wyniki zostają zwrócone od 
  # najmłodszej do najstarszej daty publikacji. 
  def order
    @order ||= ORDERS.first
  end
  
  # Zmiana porządku wyświetlania wyników w zależności od kryterium.
  # Jeżeli kryterium znajduje się na liście zdefiniowanych 
  # kryteriów, porządek sortowania jest określony według niego,
  # jeżeli nie wyniki zostają zwrócone od najmłodszej do 
  # najstarszej daty publikacji. 
  def order=(value)
    @order = value.in?(ORDERS) ? value : ORDERS.first
  end
  
  def to_params
    { q: q,
      variant_size: variant_size,
      type_id: type_id,
      fabric: fabric,
      color: color,
      
      order: order }.select{ |k,v| !v.blank? }
  end
  
  def order_column
    order.split("_")[0..-2].join("_")
  end
  
  def per
    limit
  end
  
  def per=(value)
    limit = value
  end
  
  private
  
  def filter_by_bargain
    sphinx_scope.search :conditions => { :bargain => 1 }
  end
  
  def filter_by_size
    sphinx_scope.search :conditions => { :variant_size => variant_size } if variant_size.present?
  end
  
  def search_q_and_paginate
    sphinx_scope.search conditions: { "(name,description)" => q }, per_page: limit#, page: page, per_page: limit
  end
  
end
