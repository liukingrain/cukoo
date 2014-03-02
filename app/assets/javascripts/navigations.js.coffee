ready = ->
  
  $mainCategory = $("[data-role~=main-category]")
    
  $mainCategory.on "mouseenter mouseleave", ->
    $(this).toggleClass "active"
    $subcategory = $(this).find("[data-role~=sub-category]")
    $subcategory.toggleClass "active"
    
$(document).ready(ready)
$(document).on('page:load', ready)