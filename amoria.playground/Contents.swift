/*              (✿ ♥‿♥)                 ╘[◉﹃◉]╕                      ᕙ(⇀‸↼‶)ᕗ
 Ｏ(≧▽≦)Ｏ	              ❤ Amoria ❤                       ★~(◡﹏◕✿)
 (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧            (づ￣ ³￣)づ                    (づ｡◕‿‿◕｡)づ
 */



func checkPalindrome(str: String) -> Bool {
    guard str != "" || str.characters.count != 1 else { return true }
    return str == String(str.characters.reverse())
}

checkPalindrome("racecar")
checkPalindrome("p")



func combineSortedArrays(arr1: [Int], arr2: [Int]) -> [Int] {
    var newArr = [Int]()
    for (index, element) in arr1.enumerate() {
        if element < arr2[index] {
            newArr.append(element)
        } else {
            newArr.append(arr2[index])
        }
    }
}

