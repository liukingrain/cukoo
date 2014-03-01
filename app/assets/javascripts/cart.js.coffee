ready = ->

  TIMEOUT = 2000
  listenToChange = true
  timeoutId = 0
  cart = $("#cart")
  modified = []
  preloader = cart.find(".preloader")
  
  if cart.find("[data-role~=auto-updating]").length > 0
    cart.on "click change keyup", "form [data-initial-value]", (e) ->
      handleChange(e.currentTarget)
    cart.on "click", "a[data-remove-nested-element]", (e) ->
      e.preventDefault()
      handleRemove(e.currentTarget)
  
  handleChange = (element) =>
    return if listenToChange == false
    modified = (input for input in modified when different(input, element))

    input = $(element)
    modified.push(input) if newValue(input)

    cart.find(".modified").removeClass "modified"
    for input in modified
      input.addClass("modified")

    if modified.length
      startCountdown()
    else
      stopCountdown()
      
  handleRemove = (element) =>
    return if listenToChange == false
    item = $("[data-nested-element][data-id=" + $(element).data("element-id") + "]")

    item.addClass("removed")
    handleChange $("input[data-remove-nested-element]", item).val(1)
      
  different = (input, element) =>
    if input.is(":checkbox, :radio")
      input.attr("name") != $(element).attr("name")
    else
      input[0] != element
      
  newValue = (input) =>
    input.val() != input.data("initial-value")
    
  startCountdown = () =>
    clearTimeout(timeoutId)
    timeoutId = setTimeout(countdownComplete, TIMEOUT)
    cart.addClass("loading")
  
  stopCountdown = () =>
    clearTimeout(timeoutId)
    cart.removeClass("loading")
  
  countdownComplete = () =>
    return if listenToChange == false
    submitForm()
    
  submitForm = () =>
    listenToChange = false
    cart.addClass "loading"
    preloader.addClass("visible")
    data = $("form", cart).serialize()
    url = $("form", cart).attr("action")
    cart.find('input, textarea, button, select').attr('disabled','disabled')
    $.ajax(type: "PATCH", url: url, data: data, success: render)
    listenToChange = true
    
  render = (data) =>
    listenToChange = false
    modified = []
    $(".container", cart).replaceWith(data)
    preloader.removeClass("visible")
    cart.removeClass "loading"
    clearTimeout(timeoutId)
    cart.find('input, textarea, button, select').removeAttr('disabled')
    $("[data-role~='chosen-input']").chosen()
    initializePolymorphicSelect()
    listenToChange = true
    
  initializePolymorphicSelect = () ->
    $("[data-role=polymorphic-select]", cart).each (i, el) ->
      $(el).on "change", "[data-role=polymorphic-id]", (e) ->
        $("[data-role=polymorphic-type]", el).val($(e.currentTarget).find(":selected").data("type"))
        
  $("[data-role~=billing-address-toggler]").on "change", ->
    if $(this).is(":checked")
      $("[data-role~=togglable-wrapper]").addClass "visible"
    else
      $("[data-role~=togglable-wrapper]").removeClass "visible"
    
$(document).ready(ready)
$(document).on('page:load', ready)