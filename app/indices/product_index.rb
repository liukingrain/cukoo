ThinkingSphinx::Index.define :product, :with => :active_record do
  indexes name
  indexes description
  
  has id
  has product_type
  has fabric
  has color
  has size.id, as: :size_id
end