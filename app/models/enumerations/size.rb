class Enumerations::Size < Enumerations::Base
  def self.options
    @options ||= %w(small medium large)
  end
  
  private
  
  def humanize(option)
    I18n.t("enumerations.product.size.#{option}")
  end
end