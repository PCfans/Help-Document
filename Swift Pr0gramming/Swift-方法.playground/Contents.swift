//: Playground - noun: a place where people can play

import UIKit

/*
/************************** 方法   *************
**************/
*/
//类、结构体、枚举都可以定义实例方法
//类、结构体、枚举也可以定义类型方法）（类似oc的类方法）


/************************** 实例方法   *************/
//实例方法的语法与函数完全一致
//实例方法能够隐式访问它所属类型的所有的其他实例方法和属性

class Counter {
    var count = 0
    func increament(){
        ++count
    }
    func increamentBy(amount:Int){
        count += amount
    }
    func reset(){
        count = 0
    }
}

//和调用属性一样，用点语法（dot syntax）调用实例方法：

let counter  = Counter()
counter.increamentBy(6)


/************************** 方法的局部参数名称和外部参数名称  *************/
//Swift 默认仅给方法的第一个参数名称一个局部参数名称；默认同时给第二个和后续的参数名称局部参数名称和外部参数名称。这个约定与典型的命名和调用约定相适应

class Counter1 {
    var count: Int = 0
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}
let counte1r = Counter1()
counte1r.incrementBy(5, numberOfTimes: 3)

//修改方法的外部参数名称

class Counter2 {
    func increanentby(hah : Int,_ : Int){
        
    }
}
let c2 = Counter2()
c2.increanentby(1, 2)

//self 属性(The self Property)  ||  类型的每一个实例都有一个隐含属性叫做self，self完全等同于该实例本身。

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    print("This point is to the right of the line where x == 1.0")
}

//        在实例方法中修改值类型
//结构体和枚举是值类型。一般情况下，值类型的属性不能在它的实例方法中被修改。
//你可以选择变异(mutating)这个方法，然后方法就可以从方法内部改变它的属性。方法还可以给它隐含的self属性赋值一个全新的实例，这个新实例在方法结束后将替换原来的实例。

struct Point1 {
    var x = 0.0,y = 0.0
    mutating func moveByx(detax : Double,y deltay : Double){
        x += detax
        y += deltay
    }
}
var somep = Point1(x: 1.0, y: 1.0)
print("The point is now at (\(somep.x), \(somep.y))")
var somepp = Point1()
print("The point is now at (\(somepp.x), \(somepp.y))")
somep.moveByx(2.0, y: 3.0)
print("The point is now at (\(somep.x), \(somep.y))")
//      注意，不能在结构体类型的常量上调用可变方法，因为其属性不能被改变，即使属性是变量属性

//        在可变方法中给 self 赋值,可变方法能够赋给隐含属性self一个全新的实例!

struct Point3 {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        self = Point3(x: x + deltaX, y: y + deltaY) //这个全新的实例只能是Point3结构体
    }
}
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
// ovenLight 现在等于 .High
ovenLight.next()


/************************** 类型方法 （参照类型属性，关键词是一样的）  *************/
//声明结构体和枚举的类型方法，在方法的func关键字之前加上关键字static。类可能会用关键字class来允许子类重写父类的方法实现。
//在类型方法的方法体（body）中，self指向这个类型本身/
//一个类型方法可以通过类型方法的名称调用本类中的 类型方法 和 类型属性

class SomeClass {
    static func someTypeMethod() {
    }
    class func someMethod1(){
        
    }
}

struct LevelTracker {
    static var highestUnlockedlevel = 1
    static func unlockLecel(level : Int){
        if level > highestUnlockedlevel{
            highestUnlockedlevel = level
        }
    }
    static func levelIsUnlocked(level : Int) -> Bool{
        return level <= highestUnlockedlevel
    }
    static func levelTest(){
        self.levelIsUnlocked(1)
    }
    var curentLevel = 1
    mutating func advanceToLevel(level : Int) -> Bool{
        if LevelTracker.levelIsUnlocked(level){//   为什么加LevelTracker，因为不在类方法中！为什么使用self 报错 ——》在实例方法中用类型属性和类型方法都要类名
            curentLevel = level
            return true
        }else{
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName : String
    func completedLevel(level : Int){
        LevelTracker.unlockLecel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    init(name : String){
        playerName = name;
    }
}
var player = Player(name: "Zero")
player.completedLevel(3)
print("highest unlocked level is now \(LevelTracker.highestUnlockedlevel)")

player = Player(name: "Beto")
if player.tracker.advanceToLevel(6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
