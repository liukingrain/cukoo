class Carousel
  el: null
  $el: null
  currentIndex: 0
  itemsCount: 0
  intervalId: 0
  
  constructor: (el) ->
    @el = el
    @$el = $(el)
    @itemsCount = @$("[data-role~=item]").length
    @$("[data-role~=nav-link]").on "click", @handleNavClick
    @goToCurrent()
    
  $: (selector) =>
    $(selector, @$el)
    
  goToNext: () =>
    @currentIndex = (@currentIndex + 1) % @itemsCount
    @goToCurrent()
    
    if @currentIndex >= (@itemsCount - 1)
      @$("[data-role~=nav-link].next").addClass("hidden")
    
  goToPrev: () =>
    @currentIndex = (@currentIndex - 1 + @itemsCount) % @itemsCount
    @goToCurrent()
    if @currentIndex <= 0
      @$("[data-role~=nav-link].prev").addClass("hidden")
    
  handleNavClick: (e) =>
    e.preventDefault()
    @$("[data-role~=nav-link]").removeClass("hidden")
    if $(e.currentTarget).hasClass "next"
      @goToNext()
    else
      @goToPrev()
    
  goToCurrent: () =>
    @$("[data-role~=item]").removeClass("current")
    @$("[data-role~=item]").removeClass("prev")
    @$("[data-role~=item]").removeClass("next")
    @$("[data-role~=item]:eq(#{@currentIndex}), [data-role~=item]:eq(#{@currentIndex})").addClass("current")
    @$("[data-role~=item]:eq(#{@currentIndex+1}), [data-role~=item]:eq(#{@currentIndex+1})").addClass("next")
    @$("[data-role~=item]:eq(#{@currentIndex-1}), [data-role~=item]:eq(#{@currentIndex-1})").addClass("prev")


ready = ->

  $("[data-role~=carousel]").each (i, el) ->
    new Carousel(el)


$(document).ready(ready)
$(document).on('page:load', ready)