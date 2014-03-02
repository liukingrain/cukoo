ready = ->
  
  popoverContainer = $("[data-role~=popover-container]")
  popoverContent = $("[data-role~=popover-content]")
    
    
  $("[rel~=popover]").on "click", (e) ->
    e.preventDefault()
    link = $(e.currentTarget)
    open(link.attr("href"), link.data("url"), link.data("load-in-popover"))
    
    
  open = (href, successCallback = null, loadInPopup = null) ->
    show()
    @successCallback = successCallback
    @loadInPopup = loadInPopup
    load(href)
    
  show = () ->
    popoverContainer.addClass("visible")
    
  load = (href) ->
    $.ajax
      url: href
      type: "GET"
      complete: handleResponse
      
  handleResponse = (jqXHR, textStatus) ->
    if !$.trim(jqXHR.responseText).length && @successCallback?
      if @loadInPopup?
        load(@successCallback)
      else
        window.location = @successCallback
    else
      popoverContent.html(jqXHR.responseText)
      if parseInt(jqXHR.getResponseHeader("X-Invalid-Page"))
        @requirePageReload = true

  handleClose = (e) ->
    e.preventDefault()
    if @requirePageReload
      window.location.reload()
      @requirePageReload = false
    else
      hide()
    $("html").removeClass("no-scroll")
    
  hide = () ->
    popoverContainer.removeClass "visible"
    popoverContent.html("")
    
$(document).ready(ready)
$(document).on('page:load', ready)