//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//在 Swift 中你可以对浮点数进行取余运算（%），Swift 还提供了 C 语言没有的表达两数之间的值的区间运算符（a..<b和a...b），这方便我们表达一个区间内的数值。
//Swift 只有一个三元运算符，就是三目运算符（a ? b : c）

let (x,y) = (1,2)
//与 C 语言和 Objective-C 不同，Swift 的赋值操作并不返回任何值。所以以下代码是错误的：
//if x = y {
//    // 此句错误, 因为 x = y 并不返回任何值
//}

//加法运算符也可用于String的拼接：
"hello," + "word "

//求余运算（a % b）是计算b的多少倍刚刚好可以容入a，返回多出来的那部分（余数）。在对负数b求余时，b的符号会被忽略。这意味着 a % b 和 a % -b的结果是相同的。

//不同于 C 语言和 Objective-C，Swift 中是可以对浮点数进行求余的。
8 % 2.5

//Swift 也提供了对变量本身加1或减1的自增（++）和自减（--）的缩略算符。其操作对象可以是整形和浮点型。
var i = 0.5
i++
++i
//当++前置的时候，先自増再返回。
//当++后置的时候，先返回再自增。

/*
****************** 空合运算符 ******************
*/

//空合运算符(a ?? b)将对可选类型a进行空判断，如果a包含一个值就进行解封，否则就返回一个默认值b.这个运算符有两个条件:
//表达式a必须是Optional类型
//默认值b的类型必须要和a存储值的类型保持一致
//a ?? b
//a != nil ? a! : b(化成三目好理解)
//当可选类型a的值不为空时，进行强制解封(a!)访问a中值，反之当a中值为空时，返回默认值b

let defaultColorNUme = "red"
var UserDefinedColorName :String?
var colornametouse = UserDefinedColorName ?? defaultColorNUme


/*
****************** 区间运算符 ******************
*/

//a...b ,表示a到b
for index in 1...5 {
    print("\(index) * 5 = \(index * 5)")
}
//a..<b 表示a到b-1


/*
****************** 逻辑运算符 ******************
*/

//注意： Swift 逻辑操作符&&和||是左结合的，这意味着拥有多元逻辑操作符的复合表达式优先计算最左边的子表达式。

//使用括号表示优先级

