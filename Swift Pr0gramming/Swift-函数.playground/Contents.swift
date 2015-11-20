//: Playground - noun: a place where people can play

import UIKit

/*
/**************************  函数的定义与调用   *************
**************/
*/

func sayHello(personName:String) -> String{
    let greeting = "hello " + personName + "!"
    return greeting
}

print(sayHello("Anna"))

// 无参数函数
func sayHelloWorld() ->String{
    return "hello world!"
}
print(sayHelloWorld())

// 多参数函数
func sayHello(personName : String , aleadyGreeted : Bool) -> String{
    if aleadyGreeted{
        return sayHello("wo")
    }else{
        return sayHelloWorld()
    }
}
print(sayHello("jine", aleadyGreeted: true))
//当调用超过一个参数的函数时，第一个参数后的参数根据其对应的参数名称标记

// 无返回参数
func sayGoodbye(personName: String) {
    print("Goodbye,\(personName)!")
}
sayGoodbye("davi")
// 严格上来说，虽然没有返回值被定义，sayGoodbye(_:) 函数依然返回了值。没有定义返回类型的函数会返回特殊的值，叫 Void。它其实是一个空的元组（tuple），没有任何元素，可以写成()。

// 被调用时，一个函数的返回值可以被忽略
func printAndCount(StringtoPrint : String) -> Int {
    print(StringtoPrint)
    return StringtoPrint.characters.count
}
func printWithoutCounting(stringtoPrint: String) {
    print(stringtoPrint)
}
 printAndCount("hello world")


// 多重返回值函数 可使用 元 组
func minMax(array : [Int]) -> (min : Int,max : Int){
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count]{
        if value < currentMin{
            currentMin = value
        }else if value > currentMax{
            currentMax  = value
        }
    }
    return(currentMin, currentMax)
}

let bounds = minMax([8,-2,103,8,32])
print("min is \(bounds.min) ")


// 可选元组返回类型 || 可选元组类型如(Int, Int)?与元组包含可选类型如(Int?, Int?)是不同的.可选的元组类型，整个元组是可选的，而不只是元组中的每个元素值。
func minMax1(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
if let bounds = minMax1([8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}


// 函数的参数名称 局部参数 和 外部参数
func someFunction(firstParameterName: Int, secondParameterName: Int) {
   
}
someFunction(1, secondParameterName: 2)

func sayhello(to person: String,and anotherPerson: String)->String{
    return "hello \(person) and \(anotherPerson)"
}
sayhello(to: "Bill", and: "Ted")

// 忽略参数名
func someFunction1(firstParameterName : Int, _ secondParameterName :Int){
    
}
someFunction1(1, 1)


//  默认参数值
func someFUnction(parameterWithDefault:Int = 12){
    
}
someFUnction(6)
someFUnction()


//  可变参数  ||  通过在变量类型名后面加入（...）的方式来定义可变参数。 ||  可变参数的传入值在函数体中变为此类型的一个数组
func arithmeticMean(number2:Double...) -> Double{
    var total:Double = 0
    for number in number2{
        total += number
    }
    return total / Double(number2.count)
}
arithmeticMean(1,2,3,4,5)
//一个函数最多只能有一个可变参数。 || 如果函数有一个或多个带默认值的参数，而且还有一个可变参数，那么把可变参数放在参数表的最后。



// 常量参数  和  变量参数 || 
//函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误。这意味着你不能错误地更改参数值。变量参数不是常量，你可以在函数中把它当做新的可修改副本来使用
//通过在参数名前加关键字 var 来定义变量参数：
func alignRight(var string:String, totalLenght : Int ,pad :Character) -> String{
    let amountToPad = totalLenght - string.characters.count
    if amountToPad < 1{
        return string
    }
    let padString = String(pad)
    for _ in 1...amountToPad {
        string = padString + string
    }
    return string
}
let paddesaString = alignRight("hello", totalLenght: 10, pad: "-")
//变量参数仅仅存在于函数调用的生命周期中。


// 输入输出参数 || 
//如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，
//定义一个输入输出参数时，在参数定义前加 inout 关键字
//你只能传递变量给输入输出参数。你不能传入常量或者字面量（literal value），需要在参数名前加&符
//输入输出参数不能有默认值，而且可变参数不能用 inout 标记。如果你用 inout 标记一个参数，这个参数不能被 var 或者 let 标记。

func swapTwoints(inout a:Int,inout _ b : Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoints(&someInt, &anotherInt)




/*
/**************************  函数的 类型  *************
**************/
*/
//使用函数类型
func addTwoInts(a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(a: Int, _ b: Int) -> Int {
    return a * b
}
func printHelloWorld() {
    print("hello, world")
}

var mathFunction: (Int, Int) -> Int = addTwoInts
//mathFunction 与 addTwoInts 功能一样了

//就像其他类型一样，当赋值一个函数给常量或变量时，你可以让 Swift 来推断其函数类型：

let anotherMathFunction = addTwoInts


//、、 函数类型作为参数类型
func printMathResult(mathFunction: (Int,Int) -> Int, _ a : Int, _ b : Int){
    print("Result : \(mathFunction(a,b))")
}
printMathResult(addTwoInts, 3, 5)

//、、 函数类型作为返回类型
func stepForward(input: Int) -> Int {
    return input + 1
}
func stepBackward(input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backwards : Bool) -> (Int)->Int {
    return backwards ? stepBackward : stepForward
}
var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")


//、、--------- 嵌套 函数 
//嵌套函数是对外界不可见的，但是可以被它们的外围函数（enclosing function）调用。一个外围函数也可以返回它的某一个嵌套函数，使得这个函数可以在其他域中被使用。

func chosseStepFunction(backwards: Bool) -> (Int)->Int{
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
     return backwards ? stepBackward : stepForward
}
var currentValue1 = -4
let moveNearerToZero1 = chooseStepFunction(currentValue > 0)
while currentValue1 != 0 {
    print("\(currentValue1)... ")
    currentValue1 = moveNearerToZero1(currentValue1)
}
print("zero!")