class Enumerations::ProductVariantSize < Enumerations::Base
  def self.options
    @options ||= %w(small medium big)
  end
  
  private
  
  def humanize(option)
    I18n.t("enumerations.product_variant.size.#{option}")
  end
end
