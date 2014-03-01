class ShippingAddressDecorator < AddressDecorator
  ATTRIBUTES = %w(name street_and_number postal_code city phone_number)
  
  def heading
    h.content_tag :h2, I18n.t("addresses.shipping_address.heading"), class: "heading"
  end
  
  def definition_list
    h.content_tag :dl, class: "shipping_address" do
      definition_list_contents.html_safe
    end
  end
  
  def summary
    h.content_tag :div, class: "left_column" do
      (heading + definition_list).html_safe
    end
  end

  private
  
  def definition_list_contents
    ATTRIBUTES.inject("") do |html, attribute|
      html += h.content_tag :dt, I18n.t("addresses.shipping_address.#{attribute}")
      html += h.content_tag :dd, model.send(attribute)
    end
  end
end
