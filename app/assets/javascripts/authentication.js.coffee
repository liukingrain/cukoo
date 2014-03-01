ready = ->

  $buttonLogin = $("[data-role~=cart-button-login]")
  $buttonRegister = $("[data-role~=cart-button-register]")
  $buttonGuest = $("[data-role~=cart-button-guest]")
  
  $sectionLogin = $("[data-role~=cart-section-login]")
  $sectionRegister = $("[data-role~=cart-section-register]")
  $sectionGuest = $("[data-role~=cart-section-guest]")
  
  $buttonLogin.on "click", (e) ->
    e.preventDefault()
    
    $buttonLogin.addClass "active"
    $buttonGuest.removeClass "active"
    $buttonRegister.removeClass "active"
    
    $sectionRegister.removeClass "active"
    $sectionGuest.removeClass "active"
    $sectionLogin.addClass "active"
    
  $buttonRegister.on "click", (e) ->
    e.preventDefault()
    
    $buttonGuest.removeClass "active"
    $buttonLogin.removeClass "active"
    $buttonRegister.addClass "active"
  
    $sectionRegister.addClass "active"
    $sectionGuest.removeClass "active"
    $sectionLogin.removeClass "active"
    
  $buttonGuest.on "click", (e) ->
    e.preventDefault()
    
    $buttonGuest.addClass "active"
    $buttonLogin.removeClass "active"
    $buttonRegister.removeClass "active"

    $sectionRegister.removeClass "active"
    $sectionGuest.addClass "active"
    $sectionLogin.removeClass "active"


$(document).ready(ready)
$(document).on('page:load', ready)