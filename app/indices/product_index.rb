ThinkingSphinx::Index.define :product, with: :active_record do
  indexes name
  indexes description
  indexes variants.size, as: :variant_size
  
  has id
  has fabric
  has color
  
end