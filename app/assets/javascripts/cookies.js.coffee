$(document).on "ready page:change", () =>
  cookies = $(".cookies-info")
  
  if parseInt($.cookie("hide_cookies_info")) == 1
    cookies.hide()
    
  cookies.find("[data-role~=hide-cookies-button]").on "click", (event) ->
    event.preventDefault()
    $.cookie("hide_cookies_info", 1, { expires: 365 })
    cookies.hide()