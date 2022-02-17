/*
  _  _ _      _      ___
 | || (_)__ _| |_   / __| __ ___ _ _ ___ ___
 | __ | / _` | ' \  \__ \/ _/ _ \ '_/ -_|_-<
 |_||_|_\__, |_||_| |___/\__\___/_| \___/__/
        |___/
 */


/*
 Here is a function that takes in an array of Ints along with a condition,
 and if the condition is met returns true or false.
 */

typealias longComplicatedExpression = (Int) -> Bool
func hasAnyMatches(list: [Int], condition: longComplicatedExpression) -> Bool {
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

// Learn more 🕹 https://www.udemy.com/course/level-up-in-swift/?referralCode=98AA1A570E12A5A180C3

func betweenOneAndTen(number: Int) -> Bool {
    return number >= 1 && number <= 10
}

hasAnyMatches(list: [2,3,4], condition: betweenOneAndTen) // true
hasAnyMatches(list: [0, 11], condition: betweenOneAndTen) // false
hasAnyMatches(list: [1, 11], condition: betweenOneAndTen) // true
hasAnyMatches(list: [0, 10], condition: betweenOneAndTen) // true
