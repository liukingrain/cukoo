class ProductSearch
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  extend Enumerations::Base::Mount
  
  ORDERS = %w(created_at)
  ATTRRIBUTES = %i(q page limit size_id fabric color)
                   
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
    #filter_by_fabric
    #filter_by_color
    #filter_with_complex_filters
    #search_q_and_paginate
    order_sphinx_scope
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
      page: page,
      size_id: size_id,
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
  
  def summary
    query = q unless q.blank?
    if region.present?
      [query, region.name].compact.join ", "
    elsif workplace.value != "any"
      [query, workplace.to_s.downcase].compact.join ", "
    else
      query
    end
  end
  
  private
  
  def filter_by_size
    sphinx_scope.search conditions: { size_id: size_id }
  end

  
  def search_q_and_paginate
    sphinx_scope.search conditions: { "(title,description)" => q }, page: page, per_page: limit
  end
  
  def filter_with_complex_filters
    queries = {}
    queries[:region_inclusion] = region_select_query unless region_id.blank?
    queries[:categories_elements] = category_ids_select_query unless category_ids.empty?
    queries[:category_elements] = category_select_query if category
    if queries.any?
      sphinx_scope.search(
        select: queries.values.join(", "),
        with: Hash[queries.keys.map{ |name| [name, 1] }])
    end
  end
  
  def order_sphinx_scope
    orders = []
    orders << "#{order_column} #{order_order}"
    sphinx_scope.search order: orders.join(", ")
  end
  
  def order_order
    order.split("_").pop
  end
  
end
