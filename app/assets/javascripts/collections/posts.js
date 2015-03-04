Journal.Collections.Posts = Backbone.Collection.extend({

  model: Journal.Models.Post,
  url: "posts",
  getOrFetch: function(id) {
    if (self.get(id)){
      self.get(id).fetch({});
    } else {
      var post = new Journal.Models.Post({id: id});
      post.fetch({})
    }
  }

});
