/*              (✿ ♥‿♥)                 ╘[◉﹃◉]╕                      ᕙ(⇀‸↼‶)ᕗ
 Ｏ(≧▽≦)Ｏ	              ❤ Amoria ❤                       ★~(◡﹏◕✿)
 (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧            (づ￣ ³￣)づ                    (づ｡◕‿‿◕｡)づ
 */


var dropboxLink = "https://www.dropbox.com/s/krz9q3gzygzvu3h/recordedAudio.wav?dl=0"

dropboxLink.removeAtIndex(dropboxLink.endIndex.advancedBy(-1))
dropboxLink.insert("1", atIndex: dropboxLink.endIndex)

print(dropboxLink)