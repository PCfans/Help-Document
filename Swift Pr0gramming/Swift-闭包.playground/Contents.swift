//: Playground - noun: a place where people can play

import UIKit


/*
/**************************  闭包   *************
**************/
*/
//全局和嵌套函数实际上也是特殊的闭包
//全局函数是一个有名字但不会捕获任何值的闭包、
//嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
//闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包

/**************************  使用闭包表达式   *************/

//利用上下文推断参数和返回值类型
//隐式返回单表达式闭包，即单表达式闭包可以省略return关键字
//参数名称缩写
//尾随（Trailing）闭包语法


/*
/**************************  闭包表达式    *************
**************/
*/
//嵌套函数是一个在较复杂函数中方便进行命名和定义自包含代码模块的方式
//尤其是在您处理一些函数并需要将另外一些函数作为该函数的参数时

//sort 方法
let names = ["Chris","Alex","Ewa","Barry","Daniella"]

func backwards(s1 : String, s2 : String) -> Bool{
    return s1 > s2
}
var rever = names.sort(backwards)         //普通函数版本

//闭包表达式语法
//使用常量、变量和inout类型作为参数，不能提供默认值。也可以在参数列表的最后使用可变参数。元组也可以作为参数和返回值。
/*    { (parameters) -> returnType in
        statements
    }
*/
rever = names.sort({
    (s1 : String,s2 : String) -> Bool in //闭包表达式版本
    return s1 > s2
})
rever = names.sort({(s1 : String,s2 : String) -> Bool in return s1 > s2 })


//根据上下文推断类型

//sort(_:)方法被一个字符串数组调用，因此其参数必须是(String, String) -> Bool类型的函数。
//这意味着(String, String)和Bool类型并不需要作为闭包表达式定义的一部分。因为所有的类型都可以被正确推断，返回箭头（->）和围绕在参数周围的括号也可以被省略

rever = names.sort({ s1 ,s2 in return s1 > s2})

////单表达式闭包隐式返回

rever = names.sort({s1,s2 in s1 > s2})

////参数名称缩写
//Swift 自动为内联闭包提供了参数名称缩写功能，您可以直接通过$0，$1，$2来顺序调用闭包的参数，以此类推。
// 使用了缩写，可以省略对它的定义，in 也 可以被省略

rever = names.sort({ $0 > $1})

//// 运算符函数

rever = names.sort(>)

/**************************  以上所有情况 是已知 闭包函数的 结构形式 而 进行的缩写  *************/



/*
/**************************  尾随 闭包    *************
**************/
*/
//尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为 最后一个参数！！！ 调用：
/*
func someFunctionthattakesaclosure(closure : () -> Void) {
    
}
// 以下是不使用尾随闭包进行函数调用
someFunctionthattakesaclosure({

})
// 以下是使用尾随闭包进行函数调用
someFunctionthattakesaclosure() {

}
*/
rever = names.sort({ $0 > $1})
rever = names.sort(){ $0 > $1}//改写另种形式
rever = names.sort { $0 > $1 }//尾随形式

//在map(_:)方法中使用尾随闭包将Int类型数组 -> 转换为包含对应String类型的值的数组

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (var number) -> String in
    var output = ""
    while number > 0{
        output = digitNames[number%10]! + output
        number /= 10
    }
    return output
}
//字典digitNames下标后跟着一个叹号（!），因为字典下标返回一个可选值（optional value），表明该键不存在时会查找失败



/*
/**************************  捕获值    *************
**************/
*/
//闭包可以在其被定义的上下文中捕获常量或变量
//闭包仍然可以在闭包函数体内引用和修改这些值。
func makeIncrementor(forIncrement amount:Int) -> ()->Int{
    var runningTotal = 0
    func incrementor() -> Int{
        runningTotal += amount //incrementer()函数并没有任何参数，但是在函数体内访问了runningTotal和amount变量。这是因为它从外围函数捕获了runningTotal和amount变量的引用。捕获引用保证了runningTotal和amount变量在调用完makeIncrementer后不会消失，并且保证了在下一次执行incrementer函数时，runningTotal依旧存在。
        return runningTotal
    }
    return incrementor      //返回一个函数
}
let incrementByTen = makeIncrementor(forIncrement: 10)
incrementByTen()
let incrementBySeven = makeIncrementor(forIncrement: 7)
incrementBySeven()
incrementByTen()


/*
/**************************  闭包是引用类型    *************
**************/
*/
//上面的例子中，incrementBySeven和incrementByTen是常量，但是这些常量指向的闭包仍然可以增加其捕获的变量的值。这是因为函数和闭包都是引用类型。
var alsoIncrementByTen = incrementByTen
alsoIncrementByTen()


/*
/**************************  非逃逸闭包(Nonescaping Closures)(闭包没有执行)    *************
**************/
*/
//@noescape能使编译器知道这个闭包的生命周期 
//，sort(_:)方法接受一个用来进行元素比较的闭包作为参数。这个参数被标注了@noescape，因为它确保自己在排序结束之后就没用了
func someFunctionWithNoescapeClosure(@noescape closure: () -> Void) {
    closure()
}

//    逃逸闭包示例 ： 函数返回之后才调用 闭包 || 将这个闭包保存在一个函数外部定义的变量中
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: () -> Void) {
    completionHandlers.append(completionHandler)
}

//将闭包标注为@noescape使你能在闭包中隐式地引用self。
class SomeClass {
    var x = 10
    func doSomething(){
        someFunctionWithNoescapeClosure{x = 100}
        someFunctionWithEscapingClosure{self.x = 200}
    }
}
let instance = SomeClass()
instance.doSomething()
print(instance.x)
completionHandlers.first?()         //!!!!!!
print(instance.x)


/*
/**************************  自动闭包    *************
**************/
*/
//你能够用一个普通的表达式来代替显式的闭包，从而省略闭包的花括号。
//自动闭包让你能够延迟求值，因为代码段不会被执行直到你调用这个闭包。

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider1 = {customersInLine.removeAtIndex(0)} //customerProvider是个函数，不被调用，闭包不会被执行
print(customersInLine.count)
print("Now serving \(customerProvider1())!")
print(customersInLine.count)

//将闭包作为参数传递给函数时，你能获得同样的延时求值行为。
func serveCustomer(customerProvider: () -> String) {
    print("Now serving \(customerProvider())!!!!")
}
//serveCustomer( { customersInLine.removeAtIndex(0) } )
serveCustomer(customerProvider1)      //  跟上面是一样的，表达不一样


//不过它并没有接受一个显式的闭包，而是通过将参数标记为@autoclosure来接收一个自动闭包

func serveCustomer(@autoclosure customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serveCustomer(customersInLine.removeAtIndex(0))
//、@autoclosure特性暗含了@noescape特性 ||  可以“逃逸”，则应该使用@autoclosure(escaping)特性.

var customerProviders: [() -> String] = []
func collectCustomerProviders(@autoclosure(escaping) customerProvider: () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.removeAtIndex(0))
collectCustomerProviders(customerProvider1())

print("Collected \(customerProviders.count) closures.")
for customerProvider in customerProviders {
    print("Now serving \(customerProvider1())!")
}

