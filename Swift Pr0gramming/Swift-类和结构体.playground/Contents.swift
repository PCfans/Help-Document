//: Playground - noun: a place where people can play

import UIKit

/*
/**************************  类和结构体    *************
**************/
*/
//类和结构体对比、共同点：
//定义属性用于存储值
//定义方法用于提供功能
//定义附属脚本用于访问值
//定义构造器用于生成初始化值
//通过扩展以增加默认实现的功能
//实现协议以提供某种标准功能

//                类还有如下的附加功能：

//继承允许一个类继承另一个类的特征
//类型转换允许在运行时检查和解释一个类实例的类型
//解构器允许一个类实例释放任何其所被分配的资源
//引用计数允许对一个类的多次引用

//结构体总是通过被复制的方式在代码中传递，不使用引用计数。


//                类和结构体的选择：
//该数据结构的主要目的是用来封装少量相关简单数据值。
//有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。
//该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
//该数据结构不需要去继承另一个既有类型的属性或者行为。


//字符串(String)、数组(Array)、和字典(Dictionary)类型的赋值与复制行为
//Swift 中，许多基本类型，诸如String，Array和Dictionary类型均以结构体的形式实现。这意味着被赋值给新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝。

/*
/**************************  定义语法   *************
**************/
*/

//  命名规范 用UpperCamelCase这种方式来命名（如SomeClass和SomeStructure等）
//    请使用lowerCamelCase这种方式为属性和方法命名（如framerate和incrementCount），以便和类型名区分。
class SomeClass{
    
}
struct SomeStructure {
    
}
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

/*
/**************************  实例   *************
**************/
*/

let someResolution = Resolution()
let someVideoMode = VideoMode()

//      属性访问 | 点语法
print("The width of someVideoMode is \(someVideoMode.resolution.width)")

//      结构体类型的成员逐一构造器 。类实例没有默认的成员逐一构造器
let vga = Resolution(width: 6, height: 9)

//        结构体和枚举是值类型
//。值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
//在 Swift 中，所有的基本类型：整数（Integer）、浮点数（floating-point）、布尔值（Boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，并且在底层都是以结构体的形式所实现。
//所有的结构体和枚举类型都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型属性，在代码中传递的时候都会被复制。
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("cinema is now  \(cinema.width) pixels wide")

//      类是引用类型
//它们并不“存储”这个VideoMode实例，而仅仅是对VideoMode实例的引用。所以，改变的是被引用的VideoMode的frameRate属性，而不是引用VideoMode的常量的值。
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")


//      恒等运算符
//因为类是引用类型，有可能有多个常量和变量在幕后同时引用同一个类实例。
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
}


//      指针不要求你使用星号（*）来表明你在创建一个引用。Swift 中的这些引用与其它的常量或变量的定义方式相同。
