Journal.Routers.Posts = Backbone.Router.extend({
  initialize: function(options) {
    this.$el = options.$el;
    this.collection = new Journal.Collections.Posts();
  },

  routes: {
    "" : "index",
    "posts/new": "new",
    "posts/:id" :"show",
    "posts/:id/edit": "edit"
  },

  index: function(){
    this.$el.empty();
    this.collection.fetch({
      success: function () {
        var indexView = new Journal.Views.PostsIndex({collection: this.collection});
        this.$el.append(indexView.render().$el);
      }.bind(this)
    });
  },

  show: function(id) {
    this.$el.empty();
    var post = this.collection.getOrFetch(id);
    var postView = new Journal.Views.PostShow({model: post});
    this.$el.append(postView.render().$el);
  },

  edit: function(id) {
    this.$el.empty();
    this.$el.append($("<h1> Edit Post </h1>"));
    var post = this.collection.getOrFetch(id);
    var form = new Journal.Views.PostForm({
      model: post,
      collection: this.collection});
    this.$el.append(form.render().$el);
  },

  new: function() {
    this.$el.empty();
    this.$el.append($("<h1> New Post </h1>"));
    var post = new Journal.Models.Post();
    var form = new Journal.Views.PostForm({
      model: post,
      collection: this.collection})
    this.$el.append(form.render().$el)
  }



});
