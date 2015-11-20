//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
********************简单值*****
*/

//let 编译的时候不需要明确的值，但只能赋值一次
var myVariable = 42;
myVariable = 10;
let myConstant = 12;

//如果初始值没有提供足够的信息（或者没有初始值），需要在变量后面申明类型，永茂好分割
let impliciInterger = 70;
let implicitDouble = 70.0;
let explicitDouble:Double = 70;

//显式转换
let label = "The width is";
let width  = 10;
let widthlabel = label + String(width);

//反斜杠快速转换\
let apples = 3;
let oranges = 5;
let appleSummary = "i hav \(apples) apples";
let fruitSummary = "i have \(apples + oranges) pieces of fruit."

//使用[]括号来创建数组和字典，并使用下标或者Key来访问元素，最后一个元素后面允许有个逗号
var shoplist = ["catfish","water","tulips","blue paint"];
shoplist[1] = "bottle of water"

var occupations = [
    "Malcolm":"Catain",
    "Kaylee":"Mechanic",
]
occupations["Jayne"] = "Public Relations";
//要创建一个空数组或者字典，使用初始化语句
let emptyArrat = [String]()
let emptyDictionry = [String:Float]()
//如果类型可以被推断出来，可以用[],[:]来创建空数组和空字典--就像你声明变量或者给函数传参数的时候一样
shoplist = []
occupations = [:]


/*
********************控制流************
*/

//使用 if 和 switch 条件操作，使用 for-in ，for ， while ， repea-while 循环操作。包裹条件和循环变量括号可以省略，但是语句体的大括号是必须的。
let individualScores = [75,43,108,87,12];
var teamscore = 0
for score in individualScores{
    if score > 50{
        teamscore += 3
    }else{
        teamscore += 1
    }
}
print(teamscore)

//在 if 语句中，条件必须是个布尔表达式，if score {} 的代码将报错，不会隐式跟 0 对比（不同于OC）。可以一起用 if和 let 来处理值缺失的情况，这些值可由 可选值 来代表，
//一个可选的值是一个具体的值或者是nil以表示值缺失。在类型后面加一个问号来标记这个变量的值是可选的。
var optionlString:String? = "hello"
print(optionlString == nil)
var opstionalName:String? = "John applesed"
var greeting = "Hello!"
if let name = opstionalName {
    greeting = "hello,\(name)"
}

//swich 支持任意类型的数据以及各种比较操作--不仅仅是整数或者测试相等
let vegetable = "red pepper"
switch vegetable{
    case "celery":
    print("add some raisins and make ants on alog.")
    case "cucumber","waterCress":
    print("that make a good tea andwich.")
    case let x where x.hasSuffix("pepper")://注意使用！！！
    print("Is a spicy \(x)?")
    default:
    print("Everything tastes good in soup")
}//不需要写break

//可使用 for-in 来遍历字典，需要两个变量来表示每个键值对。字典是无需的集合，可以任意顺序迭代结束
let interestingNUmbers = [
    "Prime":[2,3,4,7,9],
    "Fibonacci":[1,1,2,3,5,8],
    "Square":[1,4,9,16,35],
]
var largest = 0
for (king,numbers) in interestingNUmbers{
    for number in numbers{
        if number > largest{
            largest = number
        }
    }
}
print(largest)

//使用while 来重复运行一段代码知道不满足条件，循环条件可在结尾，保证至少循环一次
var n = 2
while n < 100{
    n = n * 2
}
print(n)
var m = 2
//repeat {
//    m = m * 2
//}while m <100
//print(m)

//可以在循环中使用..<来表示范围，也可以使用传统的写法，两者等价
var fisrtforloop = 0
for i in 0..<4{
    fisrtforloop += i
}
print(fisrtforloop)
var secondForLoop = 0
for var i = 0; i < 4; ++i {
    secondForLoop += i
}
print(secondForLoop)


/*
*****************函数和闭包************
*/

//使用 fun 来声明一个函数，使用名字和参数来调用函数，使用 -> 来指定函数返回值类型
func greet(name : String, day : String)->String{
    return "hello \(name),today is \(day)"
}
//greet(<#name: String#>, <#day: String#>)
greet("jiang", "Tuesday")

//使用元组来让一个函数返回多个值，元素可以用名称或者数字来表示
func calculateStatistics(scores: [Int])->(min:Int, max:Int, sum:Int){
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores{
        if score > max{
            max = score
        }else if score < min{
            min = score
        }
        sum += score
    }
    return (min,max,sum)
}
let statistics = calculateStatistics([2,5,6,9,1,100])
print(statistics.max)
print(statistics.2)//statistics是数组

//函数可以带有可变个数的参数，这些参数在函数内表现为数组的形式
func sumOf(numbers: Int...)->Int{//3点
    var sum = 0
    for number in numbers{
        sum += number
    }
    return sum
}
sumOf()
sumOf(1,2,3)

//函数可以嵌套，被嵌套的函数可以访问外侧函数的变量，你可以使用嵌套函数来重构一个太长或者太复杂的函数
func returnFifteen() -> Int{
    var y = 10
    func add() {//函数没返回值
        y += 5
    }
    add()
    return y
}
returnFifteen()

//函数是第一等类型，意味着函数可以作为另一个函数的返回值
func makeIncrementer() -> (Int -> Int){
    func addone(number : Int) ->Int {
        return 1 + number
    }
    return addone//函数名
}
var increment = makeIncrementer()
increment(1)//我是个函数。居然是 Var 类型

//函数可以当成参数传到另个函数
func hasAnyMatches(list: [Int],condition : Int -> Bool) ->Bool {
    for item in list{
        if condition(item){
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [10,19,17,12]
hasAnyMatches(numbers, lessThanTen)//函数名

/*
numbers.map(<#transform: (T) -> U##(T) -> U#>)
numbers.sorted(<#isOrderedBefore: (T, T) -> Bool##(T, T) -> Bool#>)
*/
//函数实际上是一种特殊的闭包：它是一段能之后被调取的代码。闭包中得代码能访问闭包所建作用域中能得到的变量和函数，即使闭包是在一个不同作用被执行的-（在嵌套函数中看到）。你可以使用一个 {} 来创建一个匿名闭包。使用 in 将参数和返回值类型声明与函数体进行分离。
numbers.map ({
    (number : Int) -> Int in
    let result  = 3 * number
    return result
})
//如果一个闭包的类型已知,比如作为一个回调函数，你可以忽略参数的类型和返回值。单个语句闭包会把它语句的值当做结果返回。
let mappedNumbers = numbers.map({number in 3 * number})
print(mappedNumbers)

//当一个闭包作为最后一个参数传给一个函数的时候，它可以直接跟在括号后面。当一个闭包是传给函数的唯一参数，你可以完全忽略括号。
numbers.sort({
    (Number1 : Int, Number2 : Int) -> Bool in
    let isbig = Number1 > Number2
    return isbig
})
let SortedNUbmers = numbers.sorted({nubmer1,nubmer2 in nubmer1 > nubmer2})
let sortedNUbmers = numbers.sorted({$0 > $1})
let sortedNumbers = numbers.sorted{$0 > $1}


/*
*******************对象和类************
*/

//使用 class 和 类名来创建一个类。类中属性的声明和常量，变量声明一样，唯一的区别就是他们的上下门是类，同样，方法和函数声明也一样
class Shape {
 var numberOfsides = 0
    func simpleDescription() -> String{
        return "A shape with \(numberOfsides) sides"
    }
}
//创建类，点语法访问市里的属性和方法
var shape = Shape()
shape.numberOfsides = 7
var shapeDiscription = shape.simpleDescription()

//使用 init 来创建一个构造器
class NamedShape {
    var numberOfsides : Int = 0
    var Name : String
    
    init(name: String){
        self.Name = name
    }
    deinit{
        //析构函数，再删除对象之前进行一些清理工作
    }
    
    func simpleDescription() -> String {
        return "A Shape with \(numberOfsides) sides"
    }
}
//子类的定义方法是在它们的类名后面加上父类的名字，创建类的时候并不需要一个标准的根类，所以你可以忽略父类。
class Square: NamedShape{
    var sideLength : Double
    
    init(NewsideLength : Double, Newname : String){
        self.sideLength = NewsideLength
        super.init(name: Newname)
        numberOfsides = 4
    }
    
    func area() -> Double{
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A Square with side of lenth \(sideLength)"
    }
}

// 属性可以有getter 和 setter 
class EquilateralTriangle: NamedShape{
    var sideLength : Double = 0.0
    
    init(newsideLength : Double, newname : String){
        self.sideLength = newsideLength
        super.init(name: newname)
        numberOfsides = 3
    }
    
    var perimeter: Double{
        get{
            return 3.0 * sideLength
        }
        set{
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "An equilateral triagle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(newsideLength: 3.1, newname: "BigT")
print(triangle.perimeter)
triangle.perimeter = 9.9
print(triangle.sideLength)

//如果你不需要计算属性，但是仍然需要在设置一个新值之前或者之后运行代码，使用willSet和didSet。
//比如，下面的类确保三角形的边长总是和正方形的边长相同。
class TriangleAndSqare{
    var triangle:EquilateralTriangle{
        willSet{
         square.sideLength = newValue.sideLength
        }
    }
    var square:Square{
        willSet{
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(size: Double,name: String){
        square = Square(NewsideLength: size, Newname: name)
        triangle = EquilateralTriangle(newsideLength: size, newname: name)
    }
}
var triangleandsquare = TriangleAndSqare(size: 10, name: "another test shape")
print(triangleandsquare.square.sideLength)
print(triangleandsquare.triangle.sideLength)
triangleandsquare.square = Square(NewsideLength:50 , Newname:"lager square" )
print(triangleandsquare.triangle.sideLength)

//处理变量的可选值时，你可以在操作（比如方法、属性和子脚本）之前加?。如果?之前的值是nil，?后面的东西都会被忽略，并且整个表达式返回nil。否则，?之后的东西都会被运行。在这两种情况下，整个表达式的值也是一个可选值。
let optionalsquare:Square? = Square(NewsideLength: 2.5, Newname: "optional square")
let sidelenth = optionalsquare?.sideLength
