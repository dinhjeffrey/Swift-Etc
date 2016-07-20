/*              (✿ ♥‿♥)                 ╘[◉﹃◉]╕                      ᕙ(⇀‸↼‶)ᕗ
 Ｏ(≧▽≦)Ｏ	              ❤ Amoria ❤                       ★~(◡﹏◕✿)
 (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧            (づ￣ ³￣)づ                    (づ｡◕‿‿◕｡)づ
 */

// LONGEST COLLATZ SEQUENCE

// method calculates how many steps it takes for a number to follow the collatz sequence (go to 1 using the even/odd technique). stores the amount of steps it takes corresponding to the index number in the array
private func collatzLength(number: Int, inout cache: [Int]) -> Int {
    var n = number
    var steps = 0
    
    while n >= number { // if goes below starting number, we looking into the cache array where we store the amount of steps to the number for all previous numbers before this number
        if n % 2 == 0 { // if even divide by 2
            n /= 2
        } else {
            n = (3*n + 1) / 2 // if odd perform 2 steps, an odd then an even, because it will become even
            steps += 1
        }
        steps += 1
    }
    steps += cache[n] // since we early exit before 1, we add the amount of steps we calculate previously for n
    cache[number] = steps // add amount of steps for original number, by indexing into the array
    
    return steps
}

// method takes in maximum number to find out the longest chain
private func longestCollatzSequence(maxNumber: Int) -> (number: Int, steps: Int) {
    var longestCollatzSequence = (number: 0, steps: 0) // initiate a tuple to store the longest sequence
    var cache = [Int](count: maxNumber, repeatedValue: 0) // initiate an array of size maxNumber to store the amount of steps for each number
    cache[1] = 1 // number 1 has 1 step, we count that too
    
    guard maxNumber != 2 else {return (1, 1)} // doesn't enter loop if maxNumber is 2, so we set it to (1, 1) since #1 has 1 step
    
    for number in 2..<maxNumber { // we use less than sign here so we can put 1_000_000 and not include it
        let calculatedSteps = collatzLength(number, cache: &cache)
        if calculatedSteps > longestCollatzSequence.steps { // compare to one value of the tuple here
            longestCollatzSequence = (number: number, steps: calculatedSteps)
        }
    }
    
    return longestCollatzSequence
}

longestCollatzSequence(5)

