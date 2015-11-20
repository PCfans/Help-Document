//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//常量的值一旦设定就不能改变，而变量的值可以随意更改。
//常量和变量必须在使用前声明，用let来声明常量，用var来声明变量。
//你可以在一行中声明多个常量或者多个变量，用逗号隔开

//你可以在一行中定义多个同样类型的变量，用逗号分割，并在最后一个变量名之后添加类型标注
var red, green, blue: Double

//常量与变量名不能包含数学符号，箭头，保留的（或者非法的）Unicode 码位，连线与制表符。也不能以数字开头，但是可以在常量与变量名的其他地方包含数字
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"

//不能将常量与变量进行互转。

//print(_:separator:terminator:)是一个用来输出一个或多个值到适当输出区的全局函数 \ 如果不想换行，可以传递一个空字符串给terminator参数--例如，print(someValue, terminator:"")

//与其他大部分编程语言不同，Swift 并不强制要求你在每条语句的结尾处使用分号（;），当然，你也可以按照你自己的习惯添加分号。有一种情况下必须要用分号，即你打算在同一行内写多条独立的语句：
let cat = "🐱"; print(cat)

//Swift 提供了8，16，32和64位的有符号和无符号整数类型比如8位无符号整数类型是UInt8，32位有符号整数类型是Int32

//在32位平台上，Int和Int32长度相同。
//在64位平台上，Int和Int64长度相同。

//Double表示64位浮点数。当你需要存储很大或者很高精度的浮点数时请使用此类型。
//Float表示32位浮点数。精度要求不高的话可以使用此类型。

//当推断浮点数的类型时，Swift 总是会选择Double而不是Float

//数值型字面量整数字面量可以被写作：
//一个十进制数，没有前缀;一个二进制数，前缀是0b;一个八进制数，前缀是0o;一个十六进制数，前缀是0x
//浮点字面量可以是十进制（没有前缀）或者是十六进制（前缀是0x）

//1.25e2 表示 1.25 × 10^2，等于 125.0。
//1.25e-2 表示 1.25 × 10^-2，等于 0.0125。

//let cannotBeNegative: UInt8 = -1
// UInt8 类型不能存储负数，所以会报错
//let tooBig: Int8 = Int8.max + 1
// Int8 类型不能存储超过最大值的数，所以会报错

let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

//整数和浮点数的转换必须显式指定类型

/*
****************** 类型 别名 ******************
*/

//类型别名（type aliases）就是给现有类型定义另一个名字。你可以使用typealias关键字来定义类型别名。类型别名非常有用。假设你正在处理特定长度的外部资源的数据
typealias Audiosample = UInt16
var maxAmplitudeFound = Audiosample.min

/*
****************** 元组 ******************
*/
//元组（tuples）把多个值组合成一个复合值。元组内的值可以是任意类型，并不要求是相同类型。
let http404Error = (404,"Not Found")
//分解
let (statucode,statusMessage) = http404Error
//如果你只需要一部分元组值，分解的时候可以把要忽略的部分用下划线（_）标记
let (justThestatucode,_) = http404Error
//下标访问
print("the statucode is \(http404Error.0)")

//定义元组是给单个元素命名
let http200sstatus = (statucode : 200, description : "OK")
print("the statu code is \(http200sstatus.statucode)")


/*
****************** 可选类型 ******************
*/

//Swift 的String类型有一种构造器，作用是将一个String值转换成一个Int值 \字符串"123"可以被转换成数字123，但是字符串"hello, world"不行。
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber 被推测为类型 "Int?"， 或者类型 "optional Int"

var serverresponseCode :Int? = 404
serverresponseCode = nil

//如果你声明一个可选常量或者变量但是没有赋值，它们会自动被设置为nil：
/*
注意：
Swift 的nil和 Objective-C 中的nil并不一样。在 Objective-C 中，nil是一个指向不存在对象的指针。在 Swift 中，nil不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选状态都可以被设置为nil，不只是对象类型。
*/
var surveyAnswer: String?
var some:String
some = "hello "


/*
****************** 错误处理 ******************
*/
//一个函数可以通过在声明中添加throws关键词来抛出错误消息。当你的函数能抛出错误消息时, 你应该在表达式中前置try关键词

func canThrowAnError() throws {
    // 这个函数有可能抛出错误
}
do {
    try canThrowAnError()
    // 没有错误消息抛出
} catch {
    // 有一个错误消息抛出
}
func makeASandwich() throws {
    //...
}
//do {
//    try makeASandwich()//有错误，执行catch
//    eatASandwich()
//} catch Error.OutOfCleanDishes {
//    washDishes()
//} catch Error.MissingIngredients(let ingredients) {
//    buyGroceries(ingredients)
//}


/*
****************** 断言 ******************
*/
let age = -3
assert(age <= 0,"a peoples age cannot be less than zero")

