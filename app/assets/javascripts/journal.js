window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new Journal.Routers.Posts({$el: $('body')});
  }
};

$(document).ready(function(){
  Journal.initialize();
  Backbone.history.start();
});
