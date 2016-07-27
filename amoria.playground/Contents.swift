/*              (✿ ♥‿♥)                 ╘[◉﹃◉]╕                      ᕙ(⇀‸↼‶)ᕗ
 Ｏ(≧▽≦)Ｏ	              ❤ Amoria ❤                       ★~(◡﹏◕✿)
 (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧            (づ￣ ³￣)づ                    (づ｡◕‿‿◕｡)づ
 */
import Foundation
// Dynamic Array


func readIntegers() -> [Int] {
    return readLine()!.componentsSeparatedByString(" ").map{ Int($0)! }
}

var input = readIntegers()
// sets 2 constants in one line
let (numOfSequences, numOfQueries) = (input[0], input[1])
var lastAns = 0
// initialize an array with a count of numOfSequences nested empty arrays inside
var seqList = [[Int]](count: numOfSequences, repeatedValue: [])

for _ in 0..<numOfQueries {
    let input = readIntegers()
    let (type, x, y) = (input[0], input[1], input[2])
    // formula to find particular sequence in seqList
    let seqListIndex = (x ^ lastAns) % numOfSequences
    // type can only be 1 or 2
    switch type {
    case 1:
        seqList[seqListIndex].append(y)
    case 2:
        let seqIndex = y % seqList[seqListIndex].count
        // find element inside sequence at index calculated right above and set to lastAns
        lastAns = seqList[seqListIndex][seqIndex]
        print(lastAns)
    default:
        fatalError("no type found")
    }
}





// 2D array
func readIntegers() -> [Int] {
    return readLine()!.componentsSeparatedByString(" ").map{ Int($0)! }
}
let rows = 6
let cols = 6
var twoDarray = [[Int]](count: rows, repeatedValue: [])
// creates the 2d array from input
for index in 0..<rows {
    twoDarray[index] = readIntegers()
}

// method calculates sum for a single hourglass
func hourglassSum(input: [[Int]], atRow row: Int, atCol col: Int) -> Int {
    var sum = input[row][col] + input[row][col+1] + input[row][col+2]
    sum += input[row+1][col+1]
    sum += input[row+2][col] + input[row+2][col+1] + input[row+2][col+2]
    return sum
}

func maxHourglassSum(input:[[Int]]) -> Int {
    var maxSum = -100 // 7 * -9 = -63
    for row in 0..<rows-2 {
        for col in 0..<cols-2 {
            let sum = hourglassSum(input, atRow: row, atCol: col)
            if sum > maxSum {
                maxSum = sum
            }
        }
    }
    return maxSum
}
print(maxHourglassSum(twoDarray))


























