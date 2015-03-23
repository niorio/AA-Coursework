Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit form": "savePokemon"
  },

  render: function () {
    this.$el.empty();
    var form = JST["pokemonForm"]
    this.$el.append(form);
    return this;
  },

  savePokemon: function (event) {
    event.preventDefault();
    var attrs = $(event.currentTarget).serializeJSON()['pokemon']
    this.model.set(attrs);
    this.model.save({}, {
      success: function () {
        this.collection.add(this.model);
        Backbone.history.navigate("pokemon/"+ this.model.id, {trigger: true});
      }.bind(this)
    });
  }
});
