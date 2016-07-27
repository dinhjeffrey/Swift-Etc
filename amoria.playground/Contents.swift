/*              (✿ ♥‿♥)                 ╘[◉﹃◉]╕                      ᕙ(⇀‸↼‶)ᕗ
 Ｏ(≧▽≦)Ｏ	              ❤ Amoria ❤                       ★~(◡﹏◕✿)
 (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧            (づ￣ ³￣)づ                    (づ｡◕‿‿◕｡)づ
 */
import Foundation

// Sparse Arrays
// reads line and converts it to an integer
func readInteger() -> Int {
    guard let line = readLine() else {
        fatalError("can't read line")
    }
    guard let i = Int(line) else {
        fatalError("line cannot be converted to int")
    }
    return i
}
// reads line and converts it to a string
func readString() -> String {
    guard let line = readLine() else {
        fatalError("cant read line")
    }
    return line
}
let numOfStrings = readInteger()
// loops over range numOfStrings and readString and puts the string in an array
let strings = (0..<numOfStrings).map { _ in
    readString()
}
let numOfQueries = readInteger()
// loops over numOfQueries and readString to get query
for _ in 0..<numOfQueries {
    let query = readString()
    // checks if query equal to any element in strings array, and keeps an accum count
    let matchingCount = strings.reduce(0) { (accum, string) in
        accum + (query == string ? 1 : 0)
    }
    print(matchingCount)
}






















