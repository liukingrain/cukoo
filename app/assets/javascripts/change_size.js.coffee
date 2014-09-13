ready = ->
  
  showDefaultPrice = () =>
    selectedVariant = $("[data-action=change-size]").find("select option:selected")
    $("[data-role=variant-price]").text(selectedVariant.data("variant-price"))


  $(document).on "change", "[data-action=change-size]", (e) ->
    selectedVariant = $(this).find("select option:selected")
    $("[data-role=variant-price]").text(selectedVariant.data("variant-price"))
    
  showDefaultPrice()

$(document).ready(ready)
$(document).on('page:load', ready)