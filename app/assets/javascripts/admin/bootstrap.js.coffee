jQuery ->  
  
  $("a[rel=popover]").each (index, element) ->
    if $(element).data("content-selector")
      $(element).popover
        content: $($(element).data("content-selector")).html()
        html: true
      $($(element).data("content-selector")).remove()
    else 
      $(element).popover()
    
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
