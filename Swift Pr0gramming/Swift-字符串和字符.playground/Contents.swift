//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//Swift 的String类型与 Foundation NSString类进行了无缝桥接
//您可以将创建的任何字符串的值转换成NSString，并调用任意的NSString API。您也可以在任意要求传入NSString实例作为参数的 API 中用String类型的值代替。

//、、字符串字面量是由双引号 ("") 包裹着的具有固定顺序的文本字符集。 字符串字面量可以用于为常量和变量提供初始值：
//注意someString常量通过字符串字面量进行初始化，Swift 会推断该常量为String类型。

//**************初始化空字符串
var emptyString = ""               // 空字符串字面量
var anotherEmptyString = String()  // 初始化方法
var somestr:String                  //不行
// 两个字符串均为空并等价。

//**************判断字符是否为空
if emptyString.isEmpty{
     print("Nothing to see here")
}

//字符串是值类型（Strings Are Value Types）传递的时候不会被修改
for character in "Dogs!".characters{
    print(character)
}

//使用通过一个标明character类型并使用字符常量或变量

let exclamationMake:Character = "i"
let catstring:[Character] = ["C","a","a","t","i","🐶"]
let catstrings = String(catstring)

//连接字符串
let str1 = "hello"
let str2 = " there"
var  weclome  = str1 + str2
var indtruction = "look over"
indtruction += weclome
//使用append 添加字符
let c:Character = "!"
weclome.append(c)

//反斜杠-------表达式不能包含非转义双引号 (") 和反斜杠 (\)，并且不能包含回车或换行符。
let multipiler = 3
let massegae = "\(multipiler) times 2.5 is \(Double(multipiler) * 2.5)"

/**************************  Unicode  *************
**************/

//swift 的 string 个character 完全兼容Unicode
//Swift 的String类型是基于 Unicode 标量 建立的。 Unicode 标量是对应字符或者修饰符的唯一的21位数字，例如U+0061表示小写的拉丁字母(LATIN SMALL LETTER A)("a")
//注意不是所有的21位 Unicode 标量都代表一个字符，因为有一些标量是留作未来分配的

/**************************  字符串字面量的特殊字符   *************
**************/
//字符串字面量可以包含以下特殊字符：
//***转义字符\0(空字符)、\\(反斜线)、\t(水平制表符)、\n(换行符)、\r(回车符)、\"(双引号)、\'(单引号)。
//___Unicode 标量，写成\u{n}(u为小写)，其中n为任意一到八位十六进制数且可用的 Unicode 位码。

let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"



/**************************  可扩展的字形群集   *************
**************/
//字母é代表了一个单一的 Swift 的Character值，同时代表了一个可扩展的字形群。 在第一种情况，这个字形群包含一个单一标量；而在第二种情况，它是包含两个标量的字形群：

let eAcute: Character = "\u{E9}"                         // é
let combinedEAcute: Character = "\u{65}\u{301}"          // e 后面加上

//在 Swift 都会表示为同一个单一的Character值
let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ

//使包围记号作为一个单一的Character值：
let enclosedEAcute: Character = "\u{E9}\u{20DD}"

//一个字符串中Character值的数量，可以使用字符串的characters属性的count属性：
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")

//注意在 Swift 中，使用可拓展的字符群集作为Character值来连接或改变字符串时，并不一定会更改字符串的字符数量。
var word = "cafe"
print("the number of characters in \(word) is \(word.characters.count)")
// 打印输出 "the number of characters in cafe is 4"

word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301

print("the number of characters in \(word) is \(word.characters.count)")



/*
/**************************  访问和修改字符串   *************
**************/
*/

//，Swift 的字符串不能用整数(integer)做索引
//endIndex属性不能作为一个字符串的有效下标。如果String是空串，startIndex和endIndex是相等的。
//获取越界索引对应的Character，将引发一个运行时错误

let greeting = "Guten Tag!"
greeting[greeting.startIndex]
greeting[greeting.endIndex.predecessor()]
greeting[greeting.startIndex.successor()]
greeting[greeting.startIndex.advancedBy(2)]

//    插入 和 删除
//调入 insert（  ：atindex： ）在指定索引插入一个字符
var weclome1  = "hello"
weclome1.insert("i", atIndex: weclome1.endIndex)
//调用insertContentsOf(_:at:)一个字符串
weclome1.insertContentsOf("iiiiiii".characters, at: weclome1.endIndex)

//removeAtindex(: at:)删除
weclome1.removeAtIndex(weclome1.startIndex)
weclome1.removeRange(weclome1.endIndex.advancedBy(-3)..<weclome1.endIndex)

/*
/**************************  比较字符串   *************
**************/
*/
//字符串比较可用 == 和 ！=
if weclome1 == weclome{
    print(weclome)
}

//如果两个字符串（或者两个字符）的可扩展的字形群集是标准相等的
// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

// "Voulez-vous un café?" 使用 LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}

//前缀和后缀相等
//通过调用字符串的hasPrefix(_:)/hasSuffix(_:)方法来检查字符串是否拥有特定前缀/后缀，两个方法均接收一个String类型的参数，并返回一个布尔值。








