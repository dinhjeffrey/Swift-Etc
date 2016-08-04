/*              (✿ ♥‿♥)                 ╘[◉﹃◉]╕                      ᕙ(⇀‸↼‶)ᕗ
 Ｏ(≧▽≦)Ｏ	              ❤ Amoria ❤                       ★~(◡﹏◕✿)
 (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧            (づ￣ ³￣)づ                    (づ｡◕‿‿◕｡)づ
 */
import Foundation

// Largest Rectangle

// returns an integer from a line of standard input
func readInteger() -> Int {
    guard let line = readLine() else { fatalError("unable to read line") }
    guard let i = Int(line) else { fatalError("unable to read integer") }
    return i
}

// returns an array of integers from a line of standard input
func readIntegers() -> [Int] {
    guard let line = readLine() else { fatalError("unable to read line") }
    let integers = line.componentsSeparatedByString(" ").map{ Int($0)! }
    return integers
}

func largestRectangle(numBuildings: Int, heightBuildings hist: [Int]) {
    var maxArea = 0
    var current = 0
    var stack = [Int]() // stack of index
    var top = Int()
    var areaWithTop = Int()
    
    while current < numBuildings {
        if stack.isEmpty || hist[stack.last!] <= hist[current] {
            stack.append(current)
            current += 1
        } else {
            top = stack.removeLast()
            
            areaWithTop = hist[top] * (stack.isEmpty ? current : current - stack.last! - 1)
            
            if maxArea < areaWithTop {
                maxArea = areaWithTop
            }
        }
    }
    while !stack.isEmpty {
        top = stack.removeLast()
        
        areaWithTop = hist[top] * (stack.isEmpty ? current : current - stack.last! - 1)
        
        if maxArea < areaWithTop {
            maxArea = areaWithTop
        }
    }
    
    print(maxArea)
}


func inputs() {
    let numBuildings = readInteger()
    let heightBuildings = readIntegers()
    largestRectangle(numBuildings, heightBuildings: heightBuildings)
}

inputs()
















