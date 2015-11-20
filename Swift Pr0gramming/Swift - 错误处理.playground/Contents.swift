//: Playground - noun: a place where people can play

import UIKit
import Foundation

/*
/************************** 错误处理（Error handling）   *************=/
**************/
*/
//错误处理 是响应错误以及从错误中恢复的过程。swift提供了在运行对可恢复错误抛出，捕获，传送和操作的高级支持。
//Swift中的错误处理涉及到错误处理模式，这会用到Cocoa和Objective-C中的NSError。关于这个class的更多信息请参见

/************************** 表示 并 抛出错误）   *************/
//在Swift中，错误用遵循ErrorType协议类型的值来表示
//Swift的枚举类型适合塑造一组错误情形，枚举的关联值还可以提供额外信息

enum VendingMachineError: ErrorType {
    case InvalidSelection   //选择无效
    case InsufficientFunds(coinsNeeded: Int)    //金额不足
    case OutOfStock         //缺货
}

//抛出一个错误会让你对所发生的意外情况做出提示，表示正常的执行流程不能被执行下去

throw VendingMachineError.InsufficientFunds(coinsNeeded: 6)


/************************** 处理错误   *************/

//某个错误被抛出时，那个地方的某部分代码必须要负责处理这个错误 - 比如纠正这个问题、尝试另外一种方式、或是给用户提示这个错误
//为了标识出这些地方，在调用一个能抛出错误的函数，方法，或者构造器之前，加上try关键字 - 或者try?或者try!的变体
//Swift中的错误处理和其他语言中的用try，catch和throw的异常处理很像。和其他语言中(包括Objective-C)的异常处理不同的是，Swift中的错误处理并不涉及堆栈解退，这是一个计算昂贵的过程。就此而言，throw语句的性能特性是可以和return语句相当的。

//        用throwing函数传递错误
//用throws关键字标来识一个可抛出错误的函数，方法或是构造器。在函数声明中的参数列表之后加上throws。一个标识了throws的函数被称作throwing函数
//只有throwing函数可以传递错误。任何在某个非throwing函数内部抛出的错误只能在此函数内部处理
/*
func canThrowErrors() throws -> String
func cannotThrowErrors() -> String
*/

struct Item {
    var price: Int
    var count: Int
}
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    
    func vend(itemNamed name: String) throws{
        guard var item = inventory[name] else{
            throw VendingMachineError.InvalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.OutOfStock
        }
        
        guard item.price <= coinsDeposited else{
            throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        --item.count
        inventory[name] = item
        dispenseSnack(name)
    }
}
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)   //。因为vend(itemNamed:)方法能抛出错误，所以在调用的它时候在它前面加了try关键字。
}

//      用 Do - Catch 处理错误
//可以使用一个do-catch语句运行一段闭包代码来做错误处理
/*
do {
    try expression
    statements
} catch pattern 1 { //如果一条catch语句没带一个模式，那么这条语句可以和任何错误相匹配，
    statements
} catch pattern 2 where condition {
    statements
}
*/
//catch语句不必将do语句中代码所抛出的每个可能的错误都处理.然而错误还是必须要被某个周围的作用域处理的 - 要么是一个外围的do-catch错误处理语句，要么是一个throwing函数的内部
//下面的代码处理了VendingMachineError枚举类型的全部3个枚举实例，但是所有其它的错误就必须由它周围作用域所处理

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.InvalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.OutOfStock {
    print("Out of Stock.")
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}


/************************** 将错误转换成可选值  *************/
//  可以使用try？ 通过将其转换成一个可选值来处理错误，如果在评估try?表达式时一个错误被抛出，那么这个表达式的值就是nil
//例如下面代码中的x和y有相同的值和特性：
//x和y都是这个类型的可选类型
func someThrowingFunction() throws -> Int {
    // ...
    return 1
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}
/*
    如果所有的方法都失败则返回nil,可以 判断多个，并封装成一个
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
*/


/**************************  使错误传递失效  *************/
//你知道某个 throwing 函数实际上在运行时是不会抛出错误的。在这种条件下，你可以在表达式前面写try!来使错误传递失效,并把调用包装在一个运行时断言中来断定不会有错误抛出
//该函数从给定的路径下装载图片资源，如果图片不能够被载入则抛出一个错误。此种情况下因为图片是和应用绑定的，运行时不会有错误被抛出，所以是错误传递失效是没问题的。
//let photo = try! loadImage("./Resources/John Appleseed.jpg")


/************************** 指定清理操作  *************/
//可以使用defer语句在代码执行到要离开当前的代码段之前去执行一套语句,该语句让你能够做一些应该被执行的必要清理工作，不管是以何种方式离开当前的代码段的 不管是错误离开还是return ，break
//defer语句将代码的执行延迟到当前的作用域退出之前。该语句由defer关键字和要被延时执行的语句组成。延时执行的语句不会包含任何会将控制权移交到语句外面的代码，例如一条break或是return语句，或是抛出一个错误
//延迟执行的操作是按照它们被指定的相反顺序执行 - 意思是第一条defer语句中的代码执行是在第二条defer语句中代码被执行之后

/*
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        defer {
            close1(file)
        }
        while let line = try file.readline() {
            // 处理文件
        }
        // 在这里，作用域的最后调用 close1(file).然后再调用 close(file)
    }
}
*/