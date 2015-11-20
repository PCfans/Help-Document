//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/*
/**************************  For 循环   *************
**************/
*/
//for in
//index是一个每次循环遍历开始时被自动赋值的常量 || index在使用前不需要声明
for index in 1...5{
    print("\(index)")
}

//可以使用下划线（_）替代变量名来忽略对值的访问
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}

//for
for var index = 0 ; index < 5; ++index{
    print("\(index)")
}


/*
/**************************  While 循环   *************
**************/
*/
//while循环，每次在循环开始时计算条件是否符合；
//repeat-while循环，每次在循环结束时计算条件是否符合。

//while循环从计算单一条件开始。如果条件为true，会重复运行一系列语句，直到条件变为false。

//下面的例子来玩一个叫做蛇和梯子的小游戏，也叫做滑道和梯子
//5 x 5 的方格
let finalSquare = 25;
var board = [Int](count: finalSquare + 1, repeatedValue: 0)

//有些方格有梯子，能爬 会 滑  、| 有正有负
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

//、、玩家由左下角编号为 0 的方格开始游戏。一般来说玩家第一次掷骰子后才会进入游戏盘面：
var square = 0;
var diceRoll = 0
while square < finalSquare{
    if ++diceRoll == 7{
        diceRoll  =  1
    }
    square += diceRoll
    if square < board.count{
        square += board[square]
    }
}
print("Game over")
//repat - while  ==  do = while ,先执行一次


/*
/**************************  IF 循环   *************
**************/
*/
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}

/*
/**************************  Switch 循环   *************
**************/
*/
//每一个 case 分支都必须包含至少一条语句。不需要在 case 分支中显式地使用break语句
//一个 case 也可以包含多个模式，用逗号把它们分开
let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
"n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) is not a vowel or a consonant")
}
//case 分支的模式允许将匹配的值绑定到一个临时的常量或变量，这些常量或变量在该 case 分支里就可以被引用了——这种行为被称为值绑定（value binding）。匹配
let anotherPoint = (2,0)
switch anotherPoint{
case(let x , 0):
    print("on the x - axis with a x Value of \(x)")
case(0 , let y):
        print("on the y 0 arise with y value of \(y)")
case (let x, let y):
    print("somewhere else at (\(x), \(y))")
}

//case 分支的模式可以使用where语句来判断额外的条件。
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("")
case let (x, y) where x == -y:
    print("")
case let (x, y):
    print("(")
}


/*
/**************************  控制转移语句   *************
**************/
*/
//continue
//break
//fallthrough
//return
//throw
//guard

//continue 立刻停止本次循环迭代 , 不离开整个循环
//注意 : 在 for 循环 使用 循环体 继续工作 只是 跳过了代码 ：++i 会执行

// Break (Switch 语句已可以不使用) 会跳出循环
//switch需要包含所有的分支而且不允许有为空的分支 |\  那么当你想忽略某个分支时，可以在该分支内写上break语句
let numberSymbol: Character = "五"  // 简体中文里的数字 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}

//  Fallthrough 贯穿

//只要第一个匹配到的 case 分支 , So 整个switch代码块完成了它的执行 Fallthrough 可以让它连接下一个分支
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
    default:
    description += " an integer."
}
print(description)


//  带标签的语句 用于 多层循环 ---> 可以控制该标签代表对象的中断或者执行。
//同一行前面放置一个标签，并且该标签后面还需带着一个冒号。下面是一个while循环体的语法，同样的规则适用于所有的循环体和switch代码块。
//label name: while condition {
//    statements
//}
//gameLoop: while square != finalSquare {
//    if ++diceRoll == 7 { diceRoll = 1 }
//    switch square + diceRoll {
//    case finalSquare:
//        // 到达最后一个方块，游戏结束
//        break gameLoop
//    case let newSquare where newSquare > finalSquare:
//        // 超出最后一个方块，再掷一次骰子
//        continue gameLoop
//    default:
//        // 本次移动有效
//        square += diceRoll
//        square += board[square]
//    }
//}
//print("Game over!")


//  guard 贯穿  guard的执行取决于一个表达式的布尔值。
// 一个guard语句总是有一个else分句

func greet(person:[String:String]){
    guard let name = person["name"]
        else{
            return
    }
    print("Hello \(name)")
    
    guard let location = person["location"]
        else{
            print("I hope the weather is nice near year")
            return
    }
    
    print("i hope the weather is nice in \(location)")
}
greet(["name":"john"])
greet(["name" : "Jane", "location" : "Cupertion"])
//如果条件不被满足，在else分支上的代码就会被执行。这个分支必须转移控制以退出guard语句出现的代码段。它可以用控制转移语句如return,break,continue或者throw做这件事，或者调用一个不返回的方法或函数，例如fatalError()。

/*
/**************************  API 检测可用性   *************
**************/
*/

if #available(iOS 9, OSX 10.10, *) {
    // 在 iOS 使用 iOS 9 的 API, 在 OS X 使用 OS X v10.10 的 API
} else {
    // 使用先前版本的 iOS 和 OS X 的 API
}

