Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    'click li': 'selectPokemonFromList'
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
  },

  addPokemonToList: function (pokemon) {
    var $li = JST["pokemonListItem"]({pokemon: pokemon});
    this.$el.append($li);
  },

  refreshPokemon: function (callback, options) {
    this.collection.fetch({
      success: function () {
        if (callback) {
          callback();
        }
        this.render();
      }.bind(this)
    })
  },

  render: function () {
    this.$el.empty();
    this.collection.each(function (poke) {
      this.addPokemonToList(poke);
    }.bind(this))

    return this;
  },

  selectPokemonFromList: function (event) {
    var poke = this.collection.get($(event.currentTarget).data('id'));

    // var pokeView = new Pokedex.Views.PokemonDetail({model: poke});
    // $("#pokedex .pokemon-detail").html(pokeView.$el);
    // pokeView.refreshPokemon();
    Backbone.history.navigate("pokemon/" + poke.id, {trigger: true});
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    'click .toys li': 'selectToyFromList'
  },

  refreshPokemon: function (callback, options) {
    this.model.fetch({
      success: function () {
        if (callback) {
          callback();
        }
        this.render();
      }.bind(this)
    });
  },

  render: function () {
    this.$el.empty();
    var div = JST["pokemonDetail"]({pokemon: this.model})
    this.$el.append(div);
    this.model.toys().each( function(toy) {
      var li = JST["toyListItem"]({toy: toy});
      this.$el.find(".toys").append(li);
    }.bind(this))
    return this;
  },

  selectToyFromList: function (event) {
    var toyId = $(event.currentTarget).data('id');
    var pokeId= $(event.currentTarget).data('pokemon-id');
    // var toy = this.model.toys().get(toyId);
    // var toyView = new Pokedex.Views.ToyDetail({ model: toy });
    // $('#pokedex .toy-detail').html(toyView.render().$el);

    Backbone.history.navigate("pokemon/"+pokeId+"/toys/"+toyId, {trigger: true})
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    this.$el.empty();
    var div = JST["toyDetail"]({toy: this.model, pokes: new Backbone.Collection()});
    this.$el.append(div)
    return this;
  }
});


// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
