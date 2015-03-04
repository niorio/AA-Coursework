Journal.Collections.Posts = Backbone.Collection.extend({

  model: Journal.Models.Post,
  url: "posts",

  getOrFetch: function(id, options) {

    var post;
    if (this.get(id)){
      post = this.get(id);
    } else {
      post = new Journal.Models.Post({id: id});
    }

    var that = this;
    post.fetch({
      success: function(){ that.add(post); }
    });

    return post;

  }
});
