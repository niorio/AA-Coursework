'use strict';

Function.prototype.myBind = function(context){
    var fn = this;
    return function(){ fn.apply(context) };
};


function Cat(name){
  this.name = name;
};

Cat.prototype.sayHello = function(){
  console.log("Hello, my name is " + this.name);
};


function Dog(name){
  this.name = name;
};


var spud = new Dog("Spud");


var sennacy = new Cat("Sennacy");

var dogHello = sennacy.sayHello.myBind(sennacy);

dogHello();

// var someFunction
