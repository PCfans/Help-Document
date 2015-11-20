//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/*
/**************************  Swift 语言提供Arrays、Sets和Dictionaries三种基本的集合类型用来存储集合数据。
数组是有序数据的集。
集合是无序无重复数据的集。
字典是无序的键值对的集。   *************
**************/
*/

//集合类型的可变性
//在我们不需要改变集合大小的时候创建不可变集合是很好的习惯。如此 Swift 编译器可以优化我们创建的集合。

//数组写 Swift 数组应该遵循像Array<Element>这样的形式
//1__创建一个空数组
var someInts = Array<Int>()
var someInt = [Int]()
print("someInts is of type [Int] with \(someInt.count) items.")
//2__已经提供了类型信息
someInt.append(3)
someInt = []
//3__创建带有默认值的数组
var sInt:Array<Double> = [0.06,0.06,0.08];
var threeDoubles = [Double](count: 3, repeatedValue: 0.09)
//4__通过其他数组创建
var anotherthreeDoubles = Array(count: 2, repeatedValue: 12)//会推断为 int
var anotherthreeDoubles1 = Array(count: 2, repeatedValue: 1.2)//会推断为 Double
var sixDoubles = threeDoubles + anotherthreeDoubles1

//5__字面量创建数组
var shoppinglist:[String] = ["Eggs","MIlke"]

/*
/**************************  访问 & 修改   *************
**************/
*/
//使用 count属性 
print("the array list contains \(shoppinglist.count)")
//使用 isEmpty 检查count 属性是否为 0 
if shoppinglist.isEmpty{
    
}

//使用 append 添加新的数据项
shoppinglist.append("FLour")

//使用 += 添加相同时数据类型
shoppinglist += ["orage","cheese"]

//索引从 0 开始
var firstItem  = shoppinglist[0]

//利用 下标 更改
shoppinglist[1...3] = ["Bananas","Apples"]

//插入
shoppinglist.insert("Map Syru", atIndex: shoppinglist.endIndex)

//移除
let mapleSyru = shoppinglist.removeAtIndex(0)

//遍历.   sort 特定顺序遍历
for item in shoppinglist{
    print(item)
}
//遍历索引，和数据
for (index,value) in shoppinglist.enumerate(){
    print("item \(String(index + 1)): \(value)")
}



/*
/**************************  Set 集合   *************
**************/
*/
//集合用来存储相同类型并且没有确定顺序的值。
//*********你可以使用你自定义的类型作为集合的值的类型或者是字典的键的类型!!!
//初始化 和 创建 一个 空的set
var letters = Set<Character>()
var strs = Set<String>()

//数组自变量创建集合
var favoriteGenres:Set<String> = ["Rock","Classical","HIp hop"]
//使用一个数组字面量构造一个Set并且该数组字面量中的所有元素类型相同
var favoriteGenres1: Set = ["Rock", "Classical", "Hip hop"]

//访问和修改
//只读属性：count
//isEmpty
if favoriteGenres1.isEmpty{
    print("")
}else {
    
}

//添加
favoriteGenres1.insert("123")

//是否包含§
favoriteGenres.contains("123")
//无序遍历
for genger in favoriteGenres{
    print("\(genger)")
}
//特定顺序
for genger in favoriteGenres.sort(){
     print("\(genger)")
}
/*
/**************************  集合操作   *************
**************/
*/

//判断集合  共有 包含 关系
let oddDigits:Set<Int> = [1,2,3,5,7,9]
let evenDigits: Set = [0,2,4,6,8]
let singleDigits: Set = [2,3,5,7]

//联合创建
oddDigits.union(evenDigits).sort()
//共有的值创建新集合
oddDigits.intersect(evenDigits).sort()
//不在该集合的值 来创建
oddDigits.subtract(singleDigits).sort()
//所有 不是共有的
oddDigits.exclusiveOr(singleDigits).sort()

//判断一个集合是否被包含在另个集合中
singleDigits.isSubsetOf(oddDigits)
//是否 包含
singleDigits.isSupersetOf(oddDigits)
// 是否是 完全 包含
singleDigits.isStrictSubsetOf(oddDigits)
// 是否 不含有相同的值
singleDigits.isDisjointWith(oddDigits)

/*
/**************************  字典   *************
**************/
*/

//创建一个空字典
var namesOfInterger = Dictionary<Int,String>()
var namesofInterger = [Int:String]()
//如果上文提供了类型信息，
namesofInterger[16] = "sixteen"
 namesofInterger = [ : ]

//字典字面量创建 || 键和值都各自拥有相同的数据类型 会推断类型
var airports:[String : String] = ["YYZ":"toronto","Dub":"Gublin"]

//访问和修改
//只读 count
// isEmpty
// 下标语法 来 添加 修改
airports["LLL"] = "London"
airports["LLL"] = "London Hearthow"

// updateValue 更新 返回 可选的旧值
if let oldvalue = airports.updateValue("AAAA", forKey: "LLL"){
    print("\(oldvalue)")
}

//下标语法 赋值 nil 删除
airports["LLL"] = nil
//removeValueForKey 返回 可选的原值
if let removedValue = airports.removeValueForKey("DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}

for (airportCode,airportName) in airports{
    print("\(airportCode) : \(airportName)");
}
for airportCode in airports.keys{
    
}

