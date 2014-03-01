class EnumerationInput < SimpleForm::Inputs::CollectionSelectInput
  def collection
    @collection ||= options.delete(:collection) || enumeration.select_options
  end
  
  private
  
  def input_options
    super.merge(selected: enumeration.value)
  end
  
  def enumeration
    @enumeration ||= @builder.object.send(attribute_name)
  end
end
