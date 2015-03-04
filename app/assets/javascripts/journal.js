window.Journal = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // alert('Hello from Backbone!');
  }
};

$(document).ready(function(){
  Journal.initialize();
  var coll = new Journal.Collections.Posts();
  coll.fetch({
    success: function () {
      var index = new Journal.Views.PostsIndex({collection: coll});
      $('body').append(index.render().$el);
    }
  })
});
