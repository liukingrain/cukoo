class BillingAddressDecorator < AddressDecorator
  def heading
    h.content_tag :h2, I18n.t("addresses.billing_address.heading"), class: "heading"
  end
  
  def definition_list
    h.content_tag :dl, class: "billing_address" do
      definition_list_contents.html_safe
    end
  end
  
  def summary
    if attributes.any?
      h.content_tag :div, class: "right_column" do
        (heading + definition_list).html_safe
      end
    end
  end
  
  private
  
  def definition_list_contents
    attributes.inject("") do |html, attribute|
      html += h.content_tag :dt, I18n.t("addresses.billing_address.#{attribute}")
      html += h.content_tag :dd, model.send(attribute)
    end
  end
  
  def attributes
    if model.invoice? && !model.custom_billing_address?
      %w(company_name company_nip)
    elsif model.custom_billing_address?
      %w(name company_name company_nip street_and_number postal_code city country_name)
    else
      []
    end
  end
end
