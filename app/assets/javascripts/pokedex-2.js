Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $li = JST["toyListItem"]({toy: toy});
  this.$pokeDetail.find(".toys").append($li);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) { // III
  this.$toyDetail.empty();

  var $detail = JST["toyDetail"]({ toy: toy , pokes: this.pokes});

  this.$toyDetail.html($detail);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var $target = $(event.target);

  var toyId = $target.data('id');
  var pokemonId = $target.data('pokemon-id');

  var pokemon = this.pokes.get(pokemonId);
  var toy = pokemon.toys().get(toyId);

  this.renderToyDetail(toy);
};
