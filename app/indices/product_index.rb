ThinkingSphinx::Index.define :product, :with => :active_record do
  indexes name
  indexes product_type
  indexes description
  indexes size
  indexes fabric  
end