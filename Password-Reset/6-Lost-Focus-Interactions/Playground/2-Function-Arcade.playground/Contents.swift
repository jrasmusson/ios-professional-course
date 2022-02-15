/*
 ___             _   _              _                  _
| __|  _ _ _  __| |_(_)___ _ _     /_\  _ _ __ __ _ __| |___
| _| || | ' \/ _|  _| / _ \ ' \   / _ \| '_/ _/ _` / _` / -_)
|_| \_,_|_||_\__|\__|_\___/_||_| /_/ \_\_| \__\__,_\__,_\___|

 */

/*
 Here is a function that takes in an array of Ints along with a condition,
 and if the condition is met returns true or false.
 */

func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}

var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)

/*
   Ready Player 1 🕹

   Write a function that returns true if any numbers are between 1 and 10 (inclusive).

   [20, 19, 7, 12] => true because of the 7
   [20, 19, 12]    => false
*/

//func betweenOneAndTen(?) -> ? {
//    // 🕹
//}

//hasAnyMatches(list: [2,3,4], condition: betweenOneAndTen) // true
//hasAnyMatches(list: [0, 11], condition: betweenOneAndTen) // false
//hasAnyMatches(list: [1, 11], condition: betweenOneAndTen) // true
//hasAnyMatches(list: [0, 10], condition: betweenOneAndTen) // true

//
// Links that help
//
// - https://docs.swift.org/swift-book/LanguageGuide/Functions.html
