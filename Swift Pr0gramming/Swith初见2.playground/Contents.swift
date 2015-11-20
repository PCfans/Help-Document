//: Playground - noun: a place where people can play

import UIKit

/*
******************枚举 和 结构体******************
*/

//使用 enum 来创建一个枚举，就像其他所有命名类型一样，枚举可以包含方法
enum Rank: Int{
    case Ace  = 10//也可以使用字符或者浮点数
    case Two, Three, four, Five, Six, Seven, Enght, Nine, Ten
    case jack, queue, king
    func simpleDescription() -> String{
        switch self{
        case .Ace:
            return "ace"
        case .jack:
            return "jack"
        case .queue:
            return "queue"
        case .king:
            return "king"
        default:
            return String(self.rawValue)//int 转 string
        }
    }
}
let ace = Rank.Ace
let acee: Rank = .Ace
let aceRawValue = ace.rawValue
ace.simpleDescription()

//使用init？(rawValue：)初始化构造器在原始值和枚举值之间进行转换
if let convertedRank = Rank(rawValue: 3){
    let threeDescription = convertedRank.simpleDescription()
}
//let convertedrank = Rank(rawValue: 0) 定义为可选值
/*
    注意，有两种方式可以引用Hearts成员：给hearts常量赋值时，枚举成员Suit.Hearts需要用全名来引用，因为常量没有显式指定类型。在switch里，枚举成员使用缩写.Hearts来引用，因为self的值已经知道是一个suit。已知变量类型的情况下你可以使用缩写。
*/
//枚举的成员值是实际值，并不是原始值的另一种表达方法。实际上，以防原始值没有意义，你不需要设置。
enum Suit {
    case Spades, Hearts, Diamonds,Clubs
    func simpleDescriptin() -> String{
        switch self {
        case .Spades:
            return "balck"
        case .Hearts:
            return "balck"
        case .Diamonds:
            return "red"
        case .Clubs:
            return "red"
        }
    }
}
let hearts = Suit.Hearts
let heartsDescription = hearts.simpleDescriptin()

//使用 struct 来创建一个结构体。结构体和类有很多相同的地方，比如方法和构造器。区别：结构体传值，类是传引用
struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescriptin())"//括号内虽然是个函数，是得到了函数的返回值，本质是个string 可用反斜杠转义
    }
}
let threeOfSpades = Card(rank: .Three, suit: .Spades)//已知变量类型的情况下你可以使用缩写
let threeOfSpadesDescription = threeOfSpades.simpleDescription()


//一个枚举成员的实例可以有实例值。相同枚举成员的实例可以有不同的值 \\ 枚举成员的原始值对于所有实例都是相同的，而且你是在定义枚举的时候设置原始值。
enum ServerResponse{
    case Result(String,String)//可理解为元组
    case Error(String)
}
let Sucess = ServerResponse.Result("6.0am", "9.00Pm")
let failure = ServerResponse.Error("out of cheese.")
switch Sucess{//Sucess还是枚举
case let .Result(sunrise,sunset):
     let serverResponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)."
case let .Error(error):
    let serverResponse = "Failure...  \(error)"
}

/*
******************协议 和 扩展******************
*/

//使用 protocol 来声明一个协议
protocol ExampleProtocol{
    var simpleDescription : String{ get }
    mutating func adjust()
}
////类 ，枚举 ，结构体都可以实现协议
class SimpleCalss :ExampleProtocol{
    var simpleDescription: String = " A very simple class."
    var anotherProperty:Int = 69105;
    func adjust() {
        simpleDescription += "  now 100% adjusted."
    }
}
var a = SimpleCalss()
a.adjust()
let adeCription  = a.simpleDescription
//注意声明SimpleStructure时候mutating关键字用来标记一个会修改结构体的方法。SimpleClass的声明不需要标记任何方法，因为类中的方法通常可以修改类属性（类的性质）
struct SimpleStruct:ExampleProtocol {
    var simpleDescription: String = " A simple Structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStruct()
b.adjust()
let bDescription = b.simpleDescription
enum SimpleEnum : ExampleProtocol {
    case one, two ,three
    var simpleDescription: String {
        get {
            switch self{
            case .one:
                return "111"
            case .two:
                return "222"
            case .three:
                return "333"
            }
        }
    }
    mutating func adjust() {
        switch self{
        case .one:
            print("1")
        case .two:
               print("2")
        case .three:
               print("3")
        }
    }
}
var c = SimpleEnum.one
print(c.simpleDescription)

//使用 extension 来为现有的类型添加功能，比如新的方法和计算属性。你可以使用 扩展(oc叫做类别) 在别处进行修改定义，甚至从外部库或者框架引入一个类型，使得这个类型遵循了某个协议
protocol simpleprotocol{
    var simplevalur:String { get}
       mutating func adjust()
}
extension Int:simpleprotocol {
    var simplevalur :String{
        return "the NUmber\(self) "
    }
//    var simpleDescription: String = " A simple Structure"
    mutating func adjust() {
      self += 10
    }
}
print(7.simplevalur)
//即使protocolValue变量运行时的类型是simpleClass，编译器会把它的类型当做ExampleProtocol。这表示你不能调用类在它实现的协议之外实现的方法或者属性。
let protocolValue :ExampleProtocol = a//a 先前已经定义为simpleclass
print(protocolValue.simpleDescription)
//print(protocolValue.anotherProperty)// simpleclass 中的属性


/*
****************** 泛 型 ******************
*/

//在尖括号里写一个名字来创建一个泛型函数或者类型 ,泛型，不确定类型
func repeatItem<Item>(item: Item,numberOfTimes:Int) -> [Item]{
    var result = [Item]()
    for _ in 0..<numberOfTimes{
        result.append(item)
    }
    return result
}
repeatItem("knock",numberOfTimes: 4)
//repeatItem("knock",numberOfTimes : 4)//文档上写的方式swift2.0,泛型前面不需要加类型

enum OptionalValue<Wrapped>{
    case None
    case Some(Wrapped)
}
var possibleInteger : OptionalValue<Int> = .None
possibleInteger = .Some(100)

//在类型名后面使用 where 来指定对类型的需求，比如，限定类型实现某一个协议，限定两个类型是相同的，或者限定某个类必须有一个特定的父类
//<T: Equatable>和<T where T: Equatable>是等价的。
func anyCommonElement <T : SequenceType, U : SequenceType where T.Generator.Element : Equatable, T.Generator.Element == U.Generator.Element>(lhs : T, rhs : U) -> Bool
{
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}
anyCommonElement([1,2,3], rhs: [2,3])

//练习： 修改EveryCommonElements(_:_:)函数来创建一个函数，返回一个数组，内容是两个序列的共有元素
//func EveryCommonElements <T : Arrone, U : Arrtwo where  T.Generator.Element == U.Generator.Element> (lhs : T, rhs : U) -> [Arrone]{
//    
//}
