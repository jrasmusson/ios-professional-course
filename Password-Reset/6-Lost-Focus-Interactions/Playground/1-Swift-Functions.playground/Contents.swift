import UIKit

/*
 ___        _  __ _     ___             _   _
/ __|_ __ _(_)/ _| |_  | __|  _ _ _  __| |_(_)___ _ _  ___
\__ \ V  V / |  _|  _| | _| || | ' \/ _|  _| / _ \ ' \(_-<
|___/\_/\_/|_|_|  \__| |_| \_,_|_||_\__|\__|_\___/_||_/__/

 */

// Functions are types: (Int, Int) -> Int

struct Math {
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    func subTwoInts(_ a: Int, _ b: Int) -> Int {
        return a - b
    }
}

// This function has a type: () -> Void

func printHelloWorld() {
    print("hello, world")
}

// Functions can be defined a variables

struct Calculator {
    var mathFunction: (Int, Int) -> Int = Math().addTwoInts
}

var calc = Calculator()

// Executed
calc.mathFunction(3, 2) // 5

// And then changed
calc.mathFunction = Math().subTwoInts

// And re-executed
calc.mathFunction(3, 2) // 1

// When function definitions get long we give them an alias

struct Calculator2 {
    typealias expression = (Int, Int) -> Int
    var mathFunction: expression = Math().addTwoInts
}

