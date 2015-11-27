//: Playground - noun: a place where people can play

import UIKit

/*
/************************** 扩展  *************=/
**************/
*/
//扩展就是向一个已有的类、结构体、枚举类型或者协议类型添加新功能（functionality）这包括在没有权限获取原始源代码的情况下扩展类型的能力（即逆向建模）
//扩展和 Objective-C 中的分类（categories）类似。（不过与 Objective-C 不同的是，Swift 的扩展没有名字。


//可以添加计算型属性和计算型静态属性
//定义实例方法和类型方法
//提供新的构造器
//定义下标
//定义和 使用新的 嵌套类型
//使一个类型复合某个协议

//，你甚至可以对一个协议(Protocol)进行扩展，提供协议需要的实现，或者添加额外的功能能够对合适的类型带来额外的好处
//扩展可以对一个类型添加新的功能，但是不能重写已有的功能。

/************************** 扩展语法  *************/
//extension SomeType {
//    // 加到SomeType的新功能写到这里
//}

//一个扩展可以扩展一个已有类型，使其能够适配一个或多个协议（protocol）。当这种情况发生时，协议的名字应该完全按照类或结构体的名字的方式进行书写：
/*
extension SomeType: SomeProtocol, AnotherProctocol {
    // 协议实现写到这里
}
*/

//如果你定义了一个扩展向一个已有类型添加新功能，那么这个新功能对该类型的所有已有实例中都是可用的，即使它们是在你的这个扩展的前面定义的。


/************************** 计算型属性 *************/

extension Double{
    var km: Double { return self * 1_000.0}
    var m: Double {
        return self;
    }
    var cm: Double{
        return self/100.0
    }
    var mm: Double{
        return self/1_000.0
    }
    var ft: Double{
        return self/3.2884
    }
}
let oneinch = 25.4.mm
let threeFeet = 3.ft
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

/************************** 构造器 *************/
//可以让你扩展其它类型，将你自己的定制类型作为其构造器参数，或者提供该类型的原始实现中未提供的额外初始化选项。
//扩展能为类添加新的便利构造器，但是它们不能为类添加新的指定构造器或析构器。指定构造器和析构器必须总是由原始的类实现来提供。

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
let defualtRect = Rect()
let menberwiseRect = Rect(origin: Point(x: 1.0, y: 2.0), size: Size(width: 5.0, height: 4.0))
extension Rect{ // 可以使用原有的init
    init(center: Point,size :Size){
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))

/************************** 方法*************/
//已有类型添加新的实例方法和类型方法
extension Int{
    func repetitions(task: () -> Void){
        for _ in 0..<self {
            task()
        }
    }
}
3.repetitions({
    print("hello")
})
3.repetitions{
    print("goodbye")
}//简洁方式

/************************** 可变实例方法 *************/
//通过扩展添加的实例方法也可以修改该实例本身。结构体和枚举类型中修改 self 或其属性的方法必须将该实例方法标注为 mutating
extension Int{//Int 类型在swift 中是 结构体 类型
    mutating func square(){
        self = self * self
    }
}
var someint = 3
someint.square()

/************************** 下标（Subscripts） *************/

extension Int{
    subscript(var digitIndex: Int) -> Int{
        var decimalBase = 1
        while digitIndex > 0 {
            decimalBase *= 10
            --digitIndex
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]

/************************** 嵌套类型） *************/
//为已有的类、结构体和枚举添加新的嵌套类型：
extension Int{
    enum Kind {
        case Negative, Zero, Positive
    }
    var kind: Kind{
        switch self{
        case 0:
            return .Zero
         case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}

func printIntergerKinds(nnumber : [Int]) {
    for munber in nnumber{
        switch munber.kind{
        case .Negative:
            print("- ", terminator: "")
        case .Zero:
            print("0 ", terminator: "")
        case .Positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntergerKinds([3, 19, -27, 0, -6, 0, 7])