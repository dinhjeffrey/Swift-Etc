/*              (✿ ♥‿♥)                 ╘[◉﹃◉]╕                      ᕙ(⇀‸↼‶)ᕗ
 Ｏ(≧▽≦)Ｏ	              ❤ Amoria ❤                       ★~(◡﹏◕✿)
 (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧            (づ￣ ³￣)づ                    (づ｡◕‿‿◕｡)づ
 */
import Foundation

// returns an integer from one line of standard input
func readInt() -> Int {
    guard let line = readLine() else {fatalError("cannot read line")}
    guard let i = Int(line) else {fatalError("cannot convert line into Int")}
    return i
}

// returns an array of characters from one line of standard input
func readChars() -> [Character] {
    guard let line = readLine() else {fatalError("cannot read line")}
    return Array(line.characters)
}

// possible brackets
enum Bracket: Character {
    case left = "("
    case right = ")"
    case leftCurly = "{"
    case rightCurly = "}"
    case leftSquare = "["
    case rightSquare = "]"
    
    // if a closing bracket, return its corresponding opening bracket
    var matchingOpen: Bracket? {
        switch self {
        case .right: return left
        case .rightCurly: return leftCurly
        case .rightSquare: return leftSquare
        default: return nil
        }
    }
}

// checks to see if the line of characters contain all matching backets
func isBalanced(sequence: [Character]) -> Bool {
    var stack = [Bracket]()
    // loop through each bracket
    for char in sequence {
        // checks to see if character is a bracket found in enum
        guard let bracket = Bracket(rawValue: char) else { fatalError("unknown bracket found");continue}
        // checks to see if bracket is a closing bracket
        // if opening bracket, append to stack
        guard let open = bracket.matchingOpen else {stack.append(bracket);continue}
        // checks to see if last element in stack matches the opening bracket, else it is not balanced
        guard let last = stack.last where last == open else {return false}
        // if passes all above, remove the top of stack
        stack.removeLast()
    }
    // returns true if empty, false if not
    return stack.isEmpty
}
func balancedBrackets() {
    let numSequences = readInt()
    for _ in 0..<numSequences {
        let sequence = readChars()
        // checks tot see if sequence is balanced
        let balanced = isBalanced(sequence)
        print(balanced ? "YES" : "NO")
    }
}

balancedBrackets()


















