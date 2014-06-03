ThinkingSphinx::Index.define :product, :with => :active_record do
  indexes name
  indexes description
  
  has product_type
  has fabric
  has color
end