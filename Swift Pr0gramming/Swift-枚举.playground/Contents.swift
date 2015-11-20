//: Playground - noun: a place where people can play

import UIKit

/*
/**************************  枚举    *************
**************/
*/
//枚举为一组相关的值定义了一个共同的类型，使你可以在你的代码中以类型安全的方式来使用这些值。
//Swift 中的枚举更加灵活，不必给每一个枚举成员提供一个值。如果给枚举成员提供一个值（称为“原始”值），则该值的类型可以是字符串，字符，或是一个整型值或浮点数。
//此外，枚举成员可以指定任意类型的关联值存储到枚举成员中，就像其他语言中的联合体（unions）和变体（variants）。每一个枚举成员都可以有适当类型的关联值。
//枚举事一等类型，支持很多特性，例如计算型属性（computed properties），用于提供枚举值的附加信息，实例方法（instance methods），用于提供和枚举值相关联的功能。枚举也可以定义构造函数（initializers）来提供一个初始值；可以在原始实现的基础上扩展它们的功能；还可以遵守协议（protocols）来提供标准的功能

//枚举语法 你使用case关键字来定义一个新的枚举成员值。
enum CompassPoint{
    case North
    case South
    case East
    case West
}
//North，South，East和West不会被隐式地赋值为0，1，2和3。相反，这些枚举成员本身就是完备的值，这些值的类型是已经明确定义好的CompassPoint类型。

//多个成员值可以出现在同一行上，用逗号隔开
enum Planet{
    case Mercury,Venus,Earth,Mars,Jupiter,Saturn,Uranus,Neptune
}
//它们的名字（例如CompassPoint和Planet）应该以一个大写字母开头

//给枚举类型起一个单数名字而不是复数名字，以便于读起来更加容易理解：
var directionToHead = CompassPoint.West
directionToHead = .East     //类型已知
directionToHead = .South
switch directionToHead {
    case .North:
        print("Lots of planets have a north")
    case .South:
        print("Watch out for penguins")
    case .East:
        print("Where the sun rises")
    case .West:
        print("Where the skies are blue")
}

// 当不需要匹配每个枚举成员的时候，你可以提供一个defualt分支来涵盖所有没明确的枚举成员
let somePlanet = Planet.Earth
switch somePlanet {
case .Earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}

/*
/**************************  关联值    *************
**************/
*/

enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}
var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
switch productBarcode {
case let .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .QRCode(productCode):
    print("QR code: \(productCode).")
}

//你可以为Planet.Earth设置一个常量或者变量、
//并且你每次在代码中使用该枚举成员时，还可以修改这个关联值 | ，每个枚举成员的关联值类型可以各不相同。



/*
/**************************  原始值    *************
**************/
*/

//枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同。
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

//    原始值的 隐式赋值
// 依次自动赋值
enum Planet1: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}
//当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称。
enum CompassPoint1: String {
    case North, South, East, West
}

//    使用 rawvalue 访问原始值
let earthsOrder = Planet1.Earth.rawValue
let sunsetDirection = CompassPoint1.West.rawValue

//    使用原始值初始化枚举实例
let possiblePlanet = Planet1(rawValue: 7)

let positionToFind = 9
if let somePlanet = Planet1(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}


/*
/**************************  递归枚举    *************
**************/
*/
//递归枚举（recursive enumeration）是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上indirect来表示该成员可递归。
enum ArithMeticExpression {
    case Number(Int)
    indirect case Addition(ArithMeticExpression,ArithMeticExpression)
    indirect case Multiplication(ArithMeticExpression, ArithMeticExpression)
}
//上面定义的枚举类型可以存储三种算术表达式：纯数字、两个表达式相加、两个表达式相乘。枚举成员Addition和Multiplication的关联值也是算术表达式——这些关联值使得嵌套表达式成为可能。

//要操作具有递归性质的数据结构，使用递归函数是一种直截了当的方式。例如，下面是一个对算术表达式求值的函数：
func evaluate(expression: ArithMeticExpression) -> Int {
    switch expression {
    case .Number(let value):
        return value
    case .Addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .Multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}
let five = ArithMeticExpression.Number(5)
let four = ArithMeticExpression.Number(4)
let sum = ArithMeticExpression.Addition(five, four)
let product = ArithMeticExpression.Multiplication(sum, ArithMeticExpression.Number(2))
print(evaluate(product))