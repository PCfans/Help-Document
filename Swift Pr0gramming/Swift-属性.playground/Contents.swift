//: Playground - noun: a place where people can play

import UIKit

/*
/**************************  属性   *************
**************/
*/
//属性将值跟特定的类、结构或枚举关联。计算属性可以用于类、结构体和枚举，存储属性只能用于类和结构体。
//存储属性和计算属性通常与特定类型的实例关联。但是，属性也可以直接作用于类型本身，这种属性称为类型属性。
//还可以定义属性观察器来监控属性值的变化，以此来触发一个自定义的操作。属性观察器可以添加到自己定义的存储属性上，也可以添加到从父类继承的属性上。、



/**************************  存储属性   *************/

//一个存储属性就是存储在特定类或结构体的实例里的一个常量或变量、
//描述了一个在创建后无法修改值域宽度的区间：
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangOfThreeItems = FixedLengthRange(firstValue: 7, length: 3)
rangOfThreeItems.firstValue = 6
print("\(rangOfThreeItems)")


/**************************  常量结构体的存储属性   *************/

//如果创建了一个结构体的实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使定义了变量存储属性
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// 该区间表示整数0，1，2，3
//rangeOfFourItems.length = 6       //报错


/**************************  延迟存储属性 （懒加载）| 不能添加属性观察器  *************/

//延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用lazy来标示一个延迟存储属性。
//必须将延迟存储属性声明成变量（使用var关键字），因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性。
//下面的例子使用了延迟存储属性来避免复杂类中不必要的初始化。
class DataImporter{
    /*
    DataImporter 是一个负责将外部文件中的数据导入的类。
    这个类的初始化会消耗不少时间。
    */
    var fileName = "data.txt"
    // 这里会提供数据导入功能
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    //这里提供数据管理功能
}

let manager = DataManager()
manager.data.append("Ome data")
manager.data.append("Some more data")
print(manager.importer.fileName)


/**************************  存储属性和实例变量   *************/
//存储属性 (类的存储属性 一定有初始值，结构体不一定)
//  计算属性 ( 有getter.setter | 必须使用var关键字定义计算属性)
//除存储属性外，类、结构体和枚举可以定义计算属性。计算属性不直接存储值，而是提供一个 getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值
struct Point{
    var x = 0.0 ,y = 0.0
}
struct Size {
    var width = 0.0 , height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center:Point{
        get{
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

//      便捷 setter 声明
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//        只读计算属性
//必须使用var关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let关键字只用来声明常量属性，表示初始化后再也无法修改的值
//只读计算属性的声明可以去掉get关键字和花括号
struct Cuboid{
    var width = 0.0 , height = 0.0 ,depth = 0.0
    var volume:Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")


/**************************  属性观察器   *************/
 
//属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，甚至新值和当前值相同的时候也不例外。
//可以为除了延迟存储属性之外的其他存储属性添加属性观察器，也可以通过重写属性的方式为继承的属性（包括存储属性和计算属性）添加属性观察器
//不需要为非重写的计算属性添加属性观察器，因为可以通过它的 setter 直接监控和响应值的变化。
// willSet 观察器会将新的属性值作为常量参数传入，在willSet的实现代码中可以为这个参数指定一个名称，如果不指定则参数仍然可用，这时使用默认名称newValue表示
// didSet 观察器会将旧的属性值作为参数传入，可以为该参数命名或者使用默认参数名oldValue。
//父类的属性在子类的构造器中被赋值时，它在父类中的willSet和didSet观察器会被调用。

class StepCounter {
    var total:Int = 0 {         //必须有一个初始值
        willSet(newtotal){
            print("\(newtotal)")
        }
        didSet{
            if total > oldValue {
                print("\(oldValue)")
            }
        }
    }
}
let stepcounter = StepCounter()
//stepcounter.total = 20
stepcounter.total = 100

struct StepOne {
    var total:Int{
        willSet{
              print("\(newValue)")
        }
        didSet(oldtotal){
              self.total = oldtotal + 100
        }
    }
}
var step1 = StepOne(total: 10)
step1.total = 100
print("\(step1.total)")


/**************************  全局变量和局部变量  (可以被 计算属性 用于计算，自己不是计算属性) *************/

//计算属性 和属性观察器所描述的功能也可以用于全局变量和局部变量
//全局或局部变量都属于存储型变量，跟存储属性类似，它为特定类型的值提供存储空间，并允许读取和写入。
//在全局或局部范围都可以定义计算型变量和为存储型变量定义观察器。计算型变量跟计算属性一样，返回一个计算结果而不是存储值，声明格式也完全一样。
var Avalue:Int = 10 {
    willSet{
        print("123")
    }
    didSet{
        print("456")
    }
}
Avalue = 100


/**************************  类型属性 语法 （类似oc中的静态变量 或 静态常量）(只指 类 的 属性)*************/
//类型属性是作为类型定义的一部分写在类型最外层的花括号内，因此它的作用范围也就在类型支持的范围内。
//使用关键字static来定义类型属性。在为类定义计算型类型属性时，可以改用关键字class来支持子类对父类的实现进行重写
struct SomeStruct{
    static var storedTypeProperty = "Some value"
    static var computerdTypeProperty :Int{
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

//        获取和设置类型属性的值 |  （实例属性是指存储属性和计算属性—）
//类型属性也是通过点运算符来访问。但是，类型属性是通过类型本身来访问，而不是通过实例属性

print(SomeStruct.computerdTypeProperty)
print("\(SomeStruct.computerdTypeProperty)")

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel:Int = 0 {
        didSet{
            if currentLevel > AudioChannel.thresholdLevel{
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // 存储当前音量作为新的最大输入音量
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}
var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

