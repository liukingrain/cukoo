module PriceHelper
  
  def format_price(price)
    number_to_currency(number_with_precision(price, precision: 2), unit: "zł", locale: :pl)
  end
  
end