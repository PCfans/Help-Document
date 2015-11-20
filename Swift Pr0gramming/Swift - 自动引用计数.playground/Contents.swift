//: Playground - noun: a place where people can play

import UIKit

/*
/************************** 自动引用计数）   *************=/
**************/
*/
//Swift 使用自动引用计数（ARC）机制来跟踪和管理你的应用程序的内存,ARC 会在类的实例不再被使用时，自动释放其占用的内存。
//引用计数仅仅应用于类的实例。结构体和枚举类型是值类型，不是引用类型，也不是通过引用的方式存储和传递。

//当你每次创建一个类的新的实例的时候，ARC 会分配一大块内存用来储存实例的信息。内存中会包含实例的类型信息，以及这个实例所有相关属性的值。
//当 ARC 收回和释放了正在被使用中的实例，该实例的属性和方法将不能再被访问和调用
//无论你将实例赋值给属性、常量或变量，它们都会创建此实例的强引用。之所以称之为“强”引用，是因为它会将实例牢牢的保持住，只要强引用还在，实例是不允许被销毁的。


/************************** 自动引用计数实践   *************/
class Person {
    let name: String
    init(name: String){
        self.name = name
        print("\(name) is being initialized")
    }
    deinit{
        print("\(name) is being deinitialized")
    }
}
//由于这些变量是被定义为可选类型（Person?，而不是Person），它们的值会被自动初始化为nil，目前还不会引用到Person类的实例。
var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")
// prints "John Appleseed is being initialized”

reference2 = reference1
reference1 = nil
reference2 = nil
// prints "John Appleseed is being deinitialized"


/************************** 类实例之间的循环强引用  *************/
//在上面的例子中，ARC 会跟踪你所新创建的Person实例的引用数量，并且会在Person实例不再被需要时销毁它。
//如果两个类实例互相持有对方的强引用，因而每个实例都让对方一直存在，就是这种情况。这就是所谓的循环强引用。
//你可以通过定义类之间的关系为弱引用或无主引用，以替代强引用，从而解决循环强引用的问题。

//下面展示了一个不经意产生循环强引用的例子
class Person1{
    let name:String
    init(name: String){ self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}
class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person1?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john: Person1?
var unit4A: Apartment?
john = Person1(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
john!.apartment = unit4A
unit4A!.tenant = john
john = nil
unit4A = nil
//Person和Apartment实例之间的强引用关系保留了下来并且不会被断开。并没打印析构的语句


/************************** 解决实例之间的循环强引用 （弱引用 & 无主引用）  *************/
//弱引用和无主引用允许循环引用中的一个实例引用另外一个实例而不保持强引用
//对于生命周期中会变为nil的实例使用弱引用
//对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用。


/************************** 弱引用  *************/
//声明属性或者变量时，在前面加上weak关键字表明这是一个弱引用。
//弱引用必须被声明为变量，表明其值能在运行时被修改。弱引用不能被声明为常量。
//你必须将每一个弱引用声明为可选类型
//但是在 ARC 中，一旦值的最后一个强引用被删除，就会被立即销毁
//在使用垃圾收集的系统里，弱指针有时用来实现简单的缓冲机制，因为没有强引用的对象只会在内存压力触发垃圾收集时才被销毁 ？？？

class Person2{
    let name:String
    init(name: String){ self.name = name }
    var apartment: Apartment1?
    deinit { print("\(name) is being deinitialized") }
}
class Apartment1 {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person2?       //自需一次weak，避免循环 强引用
    deinit { print("Apartment \(unit) is being deinitialized") }
}

//Person实例依然保持对Apartment实例的强引用，但是Apartment实例只是对Person实例的弱引用
//john变量指向Person实例的强引用
//unit4A指向Apartment实例的强引用
var john1: Person2?
var unit4A1: Apartment1?
john1 = Person2(name: "John Appleseed")
unit4A1 = Apartment1(unit: "4A")
john1!.apartment = unit4A1
unit4A1!.tenant = john1
john1 = nil
unit4A1 = nil


/************************** 无主引用  *************/
//无主引用是永远有值的。因此，无主引用总是被定义为非可选类型（non-optional type）。
//你可以在声明属性或者变量时，在前面加上关键字unowned表示这是一个无主引用。
//无主引用总是可以被直接访问。不过 ARC 无法在实例被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil。
//使用无主引用，你必须确保引用始终指向一个未销毁的实例。

//由于信用卡总是关联着一个客户，因此将customer属性定义为无主引用，用以避免循环强引用：

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String){ self.name = name }
    deinit{ print("\(name) is being deinitialized") }
}
class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer){
        self.number = number
        self.customer = customer
    }
    deinit{ print("Card #\(number) is being deinitialized")  }
}

var jack:Customer?
jack = Customer(name: "Jack Maniken")
jack!.card = CreditCard(number: 1234_5678_9012_3456, customer: jack!)
jack = nil


/************************** 无主引用以及隐式解析可选属性 *************/
//存在着第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。

class Country {
    let name: String
    var capitalCity: City!  //默认值为nil。由于capitalCity默认值为nil，一旦Country的实例在构造函数中给name属性赋值后，整个初始化过程就完成了
//    这代表一旦name属性被赋值后，Country的构造函数就能引用并传递隐式的self，就能将self作为参数传递给City的构造函数
    init(name: String, capitalName: String){
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country){
        self.name = name
        self.country = country
    }
}

//以上的意义在于你可以通过一条语句同时创建Country和City的实例，而不产生循环强引用，并且capitalCity的属性能被直接访问，而不需要通过感叹号来展开它的可选值：
var country = Country(name: "Canada", capitalName: "Oyyawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")


/************************** 闭包引起的循环强引用 *************/
//循环强引用还会发生在当你将一个闭包赋值给类实例的某个属性，并且这个闭包体中又使用了这个类实例
//循环强引用的产生，是因为闭包和类相似，都是引用类型

//展示了当一个闭包引用了self后是如何产生一个循环强引用的
class HTMLELement{
    
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {     //用@lazy来标示一个延迟存储属性,用到的时候才会只有当初始化完成以及self确实存在后，才能访问lazy属性。所以用到 self.text
//        默认情况下，闭包赋值给了asHTML属性，这个闭包返回一个代表 HTML 标签的字符串
//        如果你想改变特定元素的 HTML 处理的话，可以用自定义的闭包来取代默认值。
        if let text = self.text{
             return "<\(self.name)>\(text)</\(self.name)>"  //持有了HTMLElement实例的强引用,虽然闭包多次使用了self，它只捕获HTMLElement实例的一个强引用。
//            //可以捕获值的闭包的最简单形式是嵌套函数，也就是定义在其他函数的函数体内的函数。嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。
        }else{
             return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil){
        self.name = name;
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLELement(name: "h1")       //见 构造器设置
let defaulText = " some default text "
print(heading.asHTML())     //默认闭包
heading.asHTML = {          //自定义闭包
     return "<\(heading.name)>\(heading.text ?? defaulText)</\(heading.name)>" //空合运算符，对一个可选值进行判断，是nil 就返回 defaulText
}
print(heading.asHTML())

var paragraph: HTMLELement? = HTMLELement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
//上面的paragraph变量定义为可选HTMLElement，因此我们可以赋值nil给它来演示循环强引用

paragraph = nil
// 未执行 deinit


/************************** 解决闭包引起的循环强引用 *************/

//定义闭包时同时定义捕获列表作为闭包的一部分。通过这种方式可以解决
//。捕获列表定义了闭包体内捕获一个或者多个引用类型的规则
// 在列表内声明每个捕获的引用为弱引用或无主引用！

//Swift 有如下要求：只要在闭包内使用self的成员，就要用self.someProperty或者self.someMethod()

//      定义捕获列表

//捕获列表中的每一项都由一对元素组成，一个元素是weak或unowned关键字，另一个元素是类实例的引用（如self）或初始化过的变量，这些项在方括号中用逗号分开
/*
lazy var someClosure: (Int, String) -> String = {
    [unowned self, weak delegate = self.delegate!](index: Int, stringToProcess: String) -> String in
}
*/
//如果闭包没有指明参数列表或者返回类型
/*
lazy var someClosure: Void -> String = {
    [unowned self, weak delegate = self.delegate!] in
    // closure body goes here
}
*/

//      弱引用和无主引用
//在闭包和捕获的实例总是互相引用时并且总是同时销毁时，将闭包内的捕获定义为无主引用.被捕获的引用绝对不会变为nil
//在被捕获的引用可能会变为nil时，将闭包内的捕获定义为弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。这使我们可以在闭包体内检查它们是否存

class HTMLElement {
    
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}
var paragraph1: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph1!.asHTML())
// prints "<p>hello, world</p>"
paragraph1 = nil
// prints "p is being deinitialized"
