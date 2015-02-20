'use strict';

var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


var askIfGreaterThan = function(el1, el2, callback){
  reader.question("Is "+ el1 +" greater than "+ el2 + "? ", function(response){
    if (response === "yes"){
      callback(true);
    }
    else if (response === "no"){
      callback(false);
    }
  });
}

var innerBubbleSortLoop = function(arr, i, madeAnySwaps, outerBubbleSortLoop){
  if (i < arr.length - 1){
    askIfGreaterThan(arr[i], arr[i+1], function(isGreaterThan){
      if (isGreaterThan){
        var tmp = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = tmp;
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i+1, madeAnySwaps, outerBubbleSortLoop);
    })
  }
  else{
    outerBubbleSortLoop(madeAnySwaps);
  }
}

function absurdBubbleSort (arr, sortCompletionCallback) {
  function outerBubbleSortLoop (madeAnySwaps) {
    // Begin an inner loop if `madeAnySwaps` is true, else call
    // `sortCompletionCallback`.
    if(madeAnySwaps){
        innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    }
    else{
        sortCompletionCallback(arr);
    }
  }

  // Kick the first outer loop off, starting `madeAnySwaps` as true.
  outerBubbleSortLoop(true);
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
