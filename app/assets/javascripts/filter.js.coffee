ready = ->

  $filter = $("[data-role~=filter]")
  
  $filter.children("button.filter").on "click", ->
    $filter.toggleClass "active"
    if $filter.hasClass "active"
      $(this).find("span.text").html("Ukryj filtr")
    else
      $(this).find("span.text").html("Filtruj")
      
$(document).ready(ready)
$(document).on('page:load', ready)