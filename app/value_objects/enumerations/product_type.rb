class Enumerations::ProductType < Enumerations::Base
  def self.options
    @options ||= %w(bedclothes sheet blanket bathrobe bedspread pillowslip)
  end
  
  private
  
  def humanize(option)
    I18n.t("enumerations.product.type.#{option}")
  end
end