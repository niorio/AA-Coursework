Pokedex.Router = Backbone.Router.extend({
  routes: {
    '': "pokemonIndex",
    'pokemon/:id': "pokemonDetail",
    'pokemon/:pokemonId/toys/:id': "toyDetail"
  },

  pokemonDetail: function (id, callback) {
    var that = this;
    if (this._pokemonIndex) {
      var poke = this._pokemonIndex.collection.get(id);
      this._pokemonDetail = new Pokedex.Views.PokemonDetail({model: poke});
      $("#pokedex .pokemon-detail").html(this._pokemonDetail.$el);
      this._pokemonDetail.refreshPokemon(callback);
    } else {
      this.pokemonIndex(function(){
       that.pokemonDetail(id, callback);
     });
    }
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon(callback);
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
    this.pokemonForm();
  },

  toyDetail: function (pokemonId, toyId) {
    var that = this;
    // debugger;
    if (this._pokemonDetail){
      var toy = this._pokemonDetail.model.toys().get(toyId);
      this._toyDetail = new Pokedex.Views.ToyDetail({ model: toy });
      $('#pokedex .toy-detail').html(this._toyDetail.render().$el);
    } else{
      this.pokemonDetail(pokemonId, function(){
        that.toyDetail(pokemonId, toyId);
      });
    }
  },

  pokemonForm: function () {
    this._pokemonForm = new Pokedex.Views.PokemonForm({
      model: new Pokedex.Models.Pokemon(),
      collection: this._pokemonIndex.collection
    });
    $("#pokedex .pokemon-form").html(this._pokemonForm.render().$el);

  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
