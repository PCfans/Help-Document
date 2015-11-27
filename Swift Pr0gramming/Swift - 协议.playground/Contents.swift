//: Playground - noun: a place where people can play

import UIKit

/*
/************************** 协议（Protocols）  *************=/
**************/
*/

/************************** 协议语法  *************/
//协议的定义方式与类、结构体和枚举的定义非常相似：
protocol SomeProtocol {
    // 这里是协议的定义部分
}
struct SomeStructure: SomeProtocol {
    // 这里是结构体的定义部分
}
class SomeClass:  SomeProtocol{
    // 这里是类的定义部分
}

/************************** 属性要求  *************/
//协议可以要求采纳协议的类型提供特定名称和类型的实例属性或类型属性
//协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型
//协议还指定属性是只读的还是可读可写的
//如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读的计算型属性
//如果协议只要求属性是只读的，那么该属性不仅可以是只读的，如果代码需要的话，还可以是可写的
//协议通常用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，只读属性则用 { get } 来表示

protocol SomeProtocol1 {
    var mustBeSettable: Int {get set}
    var doesNotNeedToBeSettable: Int { get }
}

//在协议中定义类型属性时，总是使用 static 关键字作为前缀。当类类型采纳协议时，除了 static 关键字，还可以使用 class 关键字来声明类型属性
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}//这个协议表示，任何采纳 FullyNamed 的类型，都必须有一个只读的 String 类型的实例属性 fullName。

struct Person: FullyNamed {
    let fullName :String  //  必须是 fullName 关键词
}
let john = Person(fullName: "John appleseed")
//Person 结构体的每一个实例都有一个 String 类型的存储型属性 fullName

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil){
        self.name = name
        self.prefix  = prefix
    }
    var fullName: String{
        return (prefix != nil ? prefix! + "" : "" ) + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "Uss")

/************************** 方法要求  *************/
//协议可以要求采纳协议的类型实现某些指定的实例方法或类方法
//不支持为协议中的方法的参数提供默认值。不需要大括号和方法体
//在协议中定义类方法的时候，总是使用 static 关键字作为前缀。当类类型采纳协议时，除了 static 关键字，还可以使用 class 关键字作为前缀
protocol SomeProtocol2 {
    static func someTypeMethod() -> String
}
protocol RandomNumberGenerator {
    func random() -> Double
}
class Line: RandomNumberGenerator {
    var lastRandow = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandow = ((lastRandow * a + c ) % m )
        return lastRandow / m
    }
}
let generator = Line()
print("Here's a random number: \(generator.random())")

/************************** Mutating 方法要求 ±(值 类型 修改 属性)  *************/
//有时需要在方法中改变方法所属的实例,修改它所属的实例以及实例的任意属性的值
protocol Togglabel {
    mutating func toggle()
}
enum OnOffSwitch: Togglabel{
    case Off, On
    mutating func toggle() {
        switch self{
        case Off:
            self = On
        case .On:
            self = Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()

/************************** 构造器要求 *************/
//类似 方法 的 要求
protocol SomeProtocol3 {
    init(someParameter: Int)
}
//类 类型的 构造器 要求
//论是作为指定构造器，还是作为便利构造器。无论哪种情况，你都必须为构造器实现标上 required 修饰符：
class SomeClass4: SomeProtocol3 {
    required init(someParameter: Int) {     //required 表示指令构造器 ，子类重写不需要override
        // 这里是构造器的实现部分
    }
}
//        官方 并没有 这样 继承*****************
//class Myclass: SomeClass4 {
//    required init(someParameter: Int) {
//        
//    }
//}
//如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的要求
protocol SomeProtocol0 {
    init()
}

class SomeSuperClass0 {
    init() {
        // 这里是构造器的实现部分
    }
}

class SomeSubClass0: SomeSuperClass0, SomeProtocol0 {
    // 因为采纳协议，需要加上 required
    // 因为继承自父类，需要加上 override
    required override init() {
        // 这里是构造器的实现部分
    }
}

/************************** 可失败构造器要求*************/

//采纳协议的类型可以通过可失败构造器（init?）或非可失败构造器（init）来满足协议中定义的可失败构造器要求。
//协议中定义的非可失败构造器要求可以通过非可失败构造器（init）或隐式解包可失败构造器（init!）来满足。
protocol Somemyprotocol {
     init?(someParameter: Int)
    init(someParameter: Int,someParameter2: Int )
}
class Somemyclass: Somemyprotocol {
    required init?(someParameter: Int){
        
    }
    required init(someParameter: Int,someParameter2: Int ){
        
    }
}
class Somemyclass1: Somemyprotocol {
    required init(someParameter: Int){
        
    }
    required init!(someParameter: Int,someParameter2: Int ){
        
    }
}

/************************** 协议作为类型 *************/
//尽管协议本身并未实现任何功能，但是协议可以被当做一个成熟的类型来使用。（注意 驼峰 写法）
//作为函数、方法或构造器中的参数类型或返回值类型
//作为常量、变量或属性的类型
//作为数组、字典或其他容器中的元素类型
class Dice{
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int,generator: RandomNumberGenerator){      //传 满足 该协议 的类型
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int{
        return Int(generator.random() * Double(sides)) + 1
    }
}
var d6 = Dice(sides: 6, generator: Line())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

/************************** 委托（代理）模式*************/
//委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能委托给其他类型的实例

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll:Int)
    func gameDidEnd(game: DiceGame)
}
//DiceGame 协议可以被任意涉及骰子的游戏采纳。DiceGameDelegate 协议可以被任意类型采纳，用来追踪 DiceGame 的游戏过程。
class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: Line()) //
    var square = 0
    var board: [Int]
    init() {
        board = [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}
class DiceGametracker: DiceGameDelegate{
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders{
             print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        ++numberOfTurns
      print("The game is using a \(game.dice.sides)-sided dice")
    }
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}
//        可见， 就是叫别人 帮你做事 （委托）
let tracker = DiceGametracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()
// Started a new game of Snakes and Ladders
// The game is using a 6-sided dice
// Rolled a 3
// Rolled a 5
// Rolled a 4
// Rolled a 5
// The game lasted for 4 turns
