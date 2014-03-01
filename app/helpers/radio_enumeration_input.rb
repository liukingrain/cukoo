class RadioEnumerationInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  
  def collection
    @collection ||= enumeration.select_options
  end
  
  def input_type
    "radio_buttons"
  end
  
  private  
  
  def input_options
    super.merge(checked: enumeration.value)
  end
  
  def enumeration
    @enumeration ||= @builder.object.send(attribute_name)
  end
  
end
