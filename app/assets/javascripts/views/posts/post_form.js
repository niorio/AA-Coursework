Journal.Views.PostForm = Backbone.View.extend({

  initialize: function(){
    this.listenTo(this.model, 'change', this.render);
  },

  events: {'submit form' : 'savePost'},

  template: JST['posts/form'],

  render: function() {
    this.$el.empty();
    var content = this.template({post: this.model});
    this.$el.html(content);
    return this;
  },

  savePost: function() {
    event.preventDefault();
    var attrs = $(event.target).serializeJSON()['post'];
    var coll = this.collection;
    var model = this.model;

    this.model.save(attrs, {
      success: function (){
        coll.add(model, {merge: true});
        Backbone.history.navigate('', {trigger: true});
      },
      error: function(model, response) {
        errors = response.responseText;
        this.render();
        this.$el.prepend(errors);
      }.bind(this)
    })
  }
});
