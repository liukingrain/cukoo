ready = ->

  $loginLink = $("[data-role~=login-link]")
  $loginPopup = $("[data-role~=login-popup]")
  
  $registrationLink = $("[data-role~=registration-link]")
  $registrationPopup = $("[data-role~=registration-popup]")
  
  $mainCategory = $("[data-role~=main-category]")
  
  $loginLink.on "click", (e) ->
    e.stopPropagation()
    $loginPopup.addClass "active"
    $registrationPopup.removeClass "active"
    
  $registrationLink.on "click", (e) ->
    e.stopPropagation()
    $registrationPopup.addClass "active"
    $loginPopup.removeClass "active"
    
  $registrationPopup.on "click", (e) ->
    e.stopPropagation()
    
  $loginPopup.on "click", (e) ->
    e.stopPropagation()
    
  $mainCategory.on "mouseenter mouseleave", ->
    $(this).toggleClass "active"
    $subcategory = $(this).find("[data-role~=sub-category]")
    $subcategory.toggleClass "active"
    
  $("html, body").on "click", ->
    $loginPopup.removeClass "active"
    $registrationPopup.removeClass "active"
    
  $error = $registrationPopup.find("p")
  if $error.hasClass "error_notification"
    console.log $(".error_notification")
    $registrationPopup.addClass "active"
    
$(document).ready(ready)
$(document).on('page:load', ready)