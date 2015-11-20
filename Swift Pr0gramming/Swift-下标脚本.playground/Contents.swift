//: Playground - noun: a place where people can play

import UIKit

/*
/************************** 方法   *************、/
**************/
*/

//下标脚本 可以定义在类（Class）、结构体（structure）和枚举（enumeration）中，是访问集合（collection），列表（list）或序列（sequence）中元素的快捷方式。
//可以使用下标脚本的索引设置和获取值，不需要再调用对应的存取方法
//一个类型可以定义多个下标脚本，通过不同索引类型进行重载。下标脚本不限于一维，你可以定义具有多个入参的下标脚本


/************************** 下标脚本语法   **************/

//允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行存取
//与定义实例方法类似，定义下标脚本使用subscript关键字，指定一个或多个入参和返回类型。与实例方法不同的是，下标脚本可以设定为读写或只读。
/*
subscript(index: Int) ->Int{
    get{
        
    }
    set(newvalue){
        
    }
}
*/
struct TimesTable {
    let mutiplier:Int
    subscript(index: Int) -> Int{
        return mutiplier * index
    }
}
let threeTimesTable = TimesTable(mutiplier: 3)


/************************** 下标脚本用法  **************/
//下标脚本通常作为访问集合（collection），列表（list）或序列（sequence）中元素的快捷方式

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2


/************************** 下标脚本选项  **************/
//下标脚本可以接受任意数量的入参，并且这些入参可以是任意类型.下标脚本的返回值也可以是任意类型
//下标脚本可以使用变量参数和可变参数，但不能使用输入输出参数，也不能给参数设置默认值。！(不能改变值本身)
//一个类或结构体可以根据自身需要提供多个下标脚本实现，使用下标脚本时将通过入参的数量和类型进行区分，自动匹配合适的下标脚本，这就是下标脚本的重载。

struct Matrix {
    let rows:Int, columns: Int
    var grid: [Double]
    init (rows: Int, columns: Int){
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    func indexIsValidForRow(row: Int,column: Int) -> Bool{
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double{
        get{
            assert(indexIsValidForRow(row, column: column), "index out of range")
            return grid[(row * column) + column]
        }
        set{
            assert(indexIsValidForRow(row, column: column), "index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}
var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2//他是个个结构体，居然像个二维数组！！！
//let someValue = matrix[2,2]
