//: Playground - noun: a place where people can play

import UIKit

/*
/************************** 构造过程（Initialization））   *************=/
**************/
*/

/************************** 存储属性的初始赋值  *************/
//类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值
//当你为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察者


/************************** 构造器  *************/
//构造器在创建某个特定类型的新实例时被调用

struct Fahrenheit {
    var temperature: Double
    
    init() {
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")


/************************** 构造参数  *************/
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)

/************************** 参数的内部名称和外部名称  *************/
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

/************************** 不带外部名的构造器参数  *************/
struct Celsius1 {
    var temperatureInCelsius: Double
    init(_ celsius: Double){
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius1(37.0)

/************************** 可选属性类型  *************/
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()

/************************** 构造过程中常量属性的修改  *************/
// 你可以在构造过程中的任意时间点修改常量属性的值，只要在构造过程结束时是一个确定的值
// 子类可以在初始化时修改继承来的变量属性，但是不能修改继承来的常量属性。
//对于类的实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改

class SurveyQuestion1 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion1(text: "How about beets?")
beetsQuestion.ask()

/************************** 默认构造器  *************/
//如果结构体或类的所有属性都有默认值，同时没有自定义的构造器,那么 Swift 会给这些结构体或类提供一个默认构造器。这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例。
//如果结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器，即使结构体的存储型属性没有默认值。

class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()

struct Size1 {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size1(width: 2.0, height: 2.0)


/************************** 值类型的构造器代理 *************/
//构造器可以通过调用其它构造器来完成实例的部分构造过程
//构造器代理的实现规则和形式在值类型和类类型中有所不同. 值类型（结构体和枚举类型）不支持继承，所以构造器代理的过程相对简单，因为它们只能代理给提供给它的构造器。
//对于值类型，你可以使用self.init在自定义的构造器中引用类型中的其它构造器。并且你只能在构造器内部调用self.init。
//如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器
//假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器写到扩展（extension）中，而不是写在值类型的原始定义中

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
//let cent = Rect(origin: <#T##Point#>, size: <#T##Size#>))      不能使用默认构造器


/************************** 指定构造器和便利构造器 *************/
//类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值
//一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。
//每一个类都必须拥有至少一个指定构造器。
/*
init(parameters) {
    statements
}
*/

//便利构造器也采用相同样式的写法，但需要在init关键字之前放置convenience关键字，并使用空格将它们俩分开：
/*
convenience init(parameters) {
    statements
}
*/
//        类的代理器规则
//  指定构造器必须调用其直接父类的的指定构造器
//  便利构造器必须调用同一类中定义的其它构造器
//  便利构造器必须最终以调用一个指定构造器结束
//        指定构造器必须总是向上代理
//          便利构造器必须总是横向代理


/************************** 构造器的继承和重写 *************/
//Swift 中的子类默认情况下不会继承父类的构造器
//当你重写一个父类的（ 指定构造器 ）时，你总是需要写override修饰符，即使你的子类将父类的指定构造器重写为了便利构造器。
//如果你编写了一个和父类（ 便利构造器 ）相匹配的子类构造器，由于子类不能直接调用父类的便利构造器，不需要加override前缀。

class Vehicle {
    var numberOfWheels = 0
    var description: String{
        return "\(numberOfWheels) wheels"
    }
}
//自动获得的默认构造器总会是类中的指定构造器，
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        super.init()    //这步之后才会有 numberOfWheels
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")


/************************** 构造器自动继承 *************/
//  子类在默认情况下不会继承父类的构造器
//  如果满足特定条件，父类构造器是可以被自动继承的
//      1，如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。
//      2，如果子类提供了所有父类指定构造器的实现——它还将自动继承所有父类的便利构造器
//      对于规则 2，子类可以将父类的指定构造器实现为便利构造器。


/************************** 指定构造器和便利构造器实践*************/

class Food {
    var name: String
    init(name: String){
        self.name = name
    }
    convenience init(){
          self.init(name: "[Unnamed]")
    }
}
//Food类同样提供了一个没有参数的便利构造器init()
let mysteryMeat = Food()
print(mysteryMeat.name)

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int){
        self.quantity = quantity
        super.init(name: name)          //父类指定构造器的实现
    }
    override convenience init(name: String) {       //将父类的指定构造器实现为便利构造器。它依然提供了父类的所有指定构造器的实现,因此，RecipeIngredient会自动继承父类的所有便利构造器。
        self.init(name: name,quantity: 1)
    }
}
let oneMysteryItem = RecipeIngredient()     //继承父类的便利构造器
print(oneMysteryItem.name)
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

//  ShoppingList将自动继承所有父类中的指定构造器和便利构造器。
class ShoppingList: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakFastList = [
    ShoppingList(),
    ShoppingList(name: "Becon"),
    ShoppingList(name: "Eggs", quantity: 7)
]

breakFastList[0].name = "Orange juice"
breakFastList[0].purchased = true
for item    in  breakFastList{
    print(item.description)
}


/************************** 可失败构造器*************/
//所指的“失败”是指，如给构造器传入无效的参数值，或缺少某种所需的外部资源，又或是不满足某种必要的条件等。
//可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同。
//严格来说，构造器都不支持返回值。因为构造器本身的作用，只是为了确保对象能被正确构造。因此你只是用return nil表明可失败构造器构造失败，而不要用关键字return来表明构造成功。

//        结构体类型的可失败构造器
struct Animal {
    let species: String
    init?(species: String){
        if species.isEmpty{ return nil}
        self.species = species
    }
}
let someCreature = Animal(species: "Graaffe")
if let giraffe = someCreature{
     print("An animal was initialized with a species of \(giraffe.species)")
}

//        枚举类型的可失败构造器
enum TemPeratureUnit{
    case Kelvin,Celsius,Fahrenheit
    init?(symbol: Character){
        switch symbol{
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
let fahrenheitUnit = TemPeratureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print(" so initialization succeeded.")
}

//      带原始值的枚举类型的可失败构造器 (跟上面例子相同)
enum TemperatureUnit1: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}
let unknownUnit = TemperatureUnit1(rawValue: "X")
if unknownUnit == nil {
    print(" so initialization failed.")
}

//        类类型的可失败构造器
//值类型（也就是结构体或枚举）的可失败构造器，可以在构造过程中的任意时间点触发构造失败
//对类而言，可失败构造器只能在类引入的所有存储型属性被初始化后，以及构造器代理调用完成后，才能触发构造失败。

class Product {
    let name: String!       //这个惊叹号表示“我知道这个可选有值，请使用它。”这被称为可选值的强制解析
    init?(name: String){
        self.name = name
        if name.isEmpty{ return nil}
    }
}
if let bowTie = Product(name: "bow tie") {
    // 不需要检查 bowTie.name 是否为 nil
    print("The product's name is \(bowTie.name)")
}


/************************** 构造失败的传递 *************/
//无论是向上代理还是横向代理，如果你代理到的其他可失败构造器触发构造失败，整个构造过程将立即终止
//可失败构造器也可以代理到其它的非可失败构造器。通过这种方式，你可以增加一个可能的失败状态到现有的构造过程中。

class Caritem: Product {
    let quantity: Int!
    init?(name: String, quantity: Int){
        self.quantity = quantity
        super.init(name: name)
        if quantity < 1 { return nil }
    }
}
if let zeroShirts = Caritem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}


/************************** 重写一个可失败构造器 *************/
//当你用子类的非可失败构造器重写父类的可失败构造器时，向上代理到父类的可失败构造器的唯一方式是对父类的可失败构造器的返回值进行强制解包。
//不能用可失败构造器 重写 非可失败构造器

class Document {
    var name: String?
    init(){}
    init?(name: String){
        self.name = name
        if name.isEmpty { return nil }
    }
}
class UntitleDocumnet: Document {
    override init() {
      super.init(name: "[Unitiled]")!       //进行强制解包
    }
}


/************************** 可失败构造器 init! *************/
//添加问号的方式（init?）来定义一个可失败构造器
//可失败构造器（(init!)），该可失败构造器将会构建一个对应类型的隐式解包可选类型的对象。
//你可以在init?中代理到init!，反之亦然。你也可以用init?重写init!，反之亦然。你还可以用init代理到init!，不过，一旦init!构造失败，则会触发一个断言。

class Somec1{
    var name: String?
    var sex: String?
    init!(name: String){
        self.name = name
        if name.isEmpty { return nil }
    }
    convenience init?(name: String, sex: String){
         self.init(name:name)
        self.sex = sex
        if sex.isEmpty {
            return nil
        }
    }
}

if let somec = Somec1(name: "", sex: "2"){
    print("suc")
}else{
    print("no")
}


//      必要构造器
//在类的构造器前添加required修饰符表明所有该类的子类都必须实现该构造器：
//在子类重写父类的必要构造器时，必须在子类的构造器前也添加required修饰符，表明该构造器要求也应用于继承链后面的子类。!!!在重写父类中必要的指定构造器时，不需要添加override修饰符：
class SomeClass {
    var name: String
    required init() {
        // 构造器的实现代码
        self.name = "j"
    }
     init(name: String){

        self.name = name
    }
}
class SomeSubclass: SomeClass {
    required init() {       //不需要写override
        // 构造器的实现代码
        super.init()
//         self.name += "j"
    }
     override init(name: String) {
        super.init(name: name)
        self.name += name
    }
}


/************************** 通过闭包或函数设置属性的默认值 *************/
//使用闭包或全局函数为某个存储型属性提供定制的默认值
//每当某个属性所在类型的新实例被创建时，对应的闭包或函数会被调用，而它们的返回值会当做默认值赋值给这个属性

//class SomeClasss {
//    let someProperty: SomeType = {
//        // 在这个闭包中给 someProperty 创建一个默认值
//        // someValue 必须和 SomeType 类型相同
//        return someValue
//    }()
//}

//闭包结尾的大括号后面接了一对空的小括号。这用来告诉 Swift 立即执行此闭包。如果你忽略了这对括号，相当于将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性

struct Checkrboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAtrow(row: Int, column: Int) -> Bool{
        return boardColors[(row * 10) + column]
    }
}
let board = Checkrboard()
print(board.squareIsBlackAtrow(1, column: 1)

