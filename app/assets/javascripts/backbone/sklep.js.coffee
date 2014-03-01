#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Sklep =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  
$ ->
  window.app = new Sklep.Views.AppView(el: $("body"))