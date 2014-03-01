class Sklep.Views.MainCategoryView extends Backbone.View
  events:
    "mouseenter": "handleShowSubmenu"
    "mouseleave": "handleHideSubmenu"
    
  initialize: (options = {}) =>
    @initializeElements()
    
  initializeElements: =>
    @$subcategory = @$("[data-role~=sub-category]")
    
  handleShowSubmenu: (e) =>
    @$el.addClass "active"
    @$subcategory.addClass "active"
    
  handleHideSubmenu: (e) =>
    @$el.removeClass "active"
    @$subcategory.removeClass "active"