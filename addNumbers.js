"use strict";

var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

//reader.question("what's up?", function(){ console.log("hi"); reader.close();});

var addNumbers = function(sum, numsLeft, completionCallback)
{
    if(numsLeft > 0)
    {
        var callback = function(input)
        {
            var num = parseInt(input);
            sum += num;
            numsLeft -= 1;
            console.log(sum);
            addNumbers(sum, numsLeft, completionCallback);
        };

        reader.question("Enter a number.", callback);
    }
    else
    {
        completionCallback(sum);
        reader.close();
    };
};


addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
});
