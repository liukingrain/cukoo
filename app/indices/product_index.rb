ThinkingSphinx::Index.define :product, with: :active_record do
  indexes name
  indexes description
  
  has id
  has fabric
  has color
  has size_id
  has type_id
  
  set_property field_weights: {
    title: 6,
    description: 3
  }
  
end