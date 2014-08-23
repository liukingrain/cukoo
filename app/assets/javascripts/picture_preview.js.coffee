ready = ->
  
  preview = $("[data-role~=images-preview]")
  nav = $("[data-role~=images-preview-nav]")
  navButton = nav.find("li")
  
  navButton.first().addClass "active"
  
  navButton.on "click", (e) ->
    e.preventDefault()
    navButton.removeClass "active"
    $(this).addClass "active"
    data = $(this).attr("data-role")
    goToPicture(data.slice(-1))
    
  goToPicture = (number) =>
    preview.css("top", -330*number)
  
$(document).ready(ready)
$(document).on('page:load', ready)