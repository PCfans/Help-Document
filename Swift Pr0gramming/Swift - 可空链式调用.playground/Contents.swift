//: Playground - noun: a place where people can play

import UIKit

/*
/************************** 可空链式调用   *************=/
**************/
*/

//可空链式调用（Optional Chaining）是一种可以请求和调用属性、方法及下标的过程，它的可空性体现于请求或调用的目标当前可能为空（nil）
//多个连续的调用可以被链接在一起形成一个调用链，如果其中任何一个节点为空（nil）将导致整个链调用失败。
//Swift 的可空链式调用和 Objective-C 中的消息为空有些相像，但是 Swift 可以使用在任意类型中，并且能够检查调用是否成功

/************************** 使用可空链式调用来强制展开 *************/

//通过在想调用非空的属性、方法、或下标的可空值（optional value）后面放一个问号，可以定义一个可空链。这一点很像在可空值后面放一个叹号（！）来强制展开其中值，区别在于当可空值为空时可空链式只是调用失败，然而强制展开将会触发运行时错误。

//为了反映可空链式调用可以在空对象（nil）上调用，不论这个调用的属性、方法、下标等返回的值是不是可空值，它的返回结果都是一个可空值。返回nil则说明调用失败。

//可空链式调用的返回结果与原本的返回结果具有相同的类型，但是被包装成了一个可空类型值。当可空链式调用成功时，一个本应该返回Int的类型的结果将会返回Int?类型。

//解释可空链式调用和强制展开的不同：

//        个人理解：当一个类的实例是另一个了类的 可空 实例属性时

class Person {
    var residence: Residence?
}
class Residence {
    var numberOfRooms = 1
}

let john = Person()
//let roomCount = john.residence!.numberOfRooms
//运行时错误,没有可以展开的residence

john.residence = Residence()

//  可空链式调用提供了一种另一种访问numberOfRooms的方法，使用问号（？）来代替原来叹号（！）的位置：
//  只要是通过可空链式调用就意味着最后numberOfRooms返回一个Int?而不是Int。
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}


/************************** 为可空链式调用定义模型类 *************/
class Person1 {
    var residence: Residence1?
}
class Residence1 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}
class Room {
    let name: String
    init(name: String) { self.name = name }
}
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil {
            return buildingNumber
        } else {
            return nil
        }
    }
}

//      通过可空链式调用访问属性
let john1 = Person1()
if let roomCount = john1.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia road"
john1.residence?.address = someAddress

//      通过可空链式调用来调用方法
if john1.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

//      通过可空链式调用来访问下标
if let firstRoomName = john1.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
//  赋值
john1.residence?[0] = Room(name: "Bathroom")

let johnsHouse = Residence1()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john1.residence = johnsHouse

if let firstRoomName = john1.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

//      访问可空类型的下标
//如果下标返回可空值类型，比如Swift中Dictionary的key下标。可以在下标的闭合括号后面放一个问号来链接下标的可空返回值：
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0]++
testScores["Brian"]?[0] = 72


/************************** 多层链接 *************/
//多层可空链式调用不会添加返回值的可空性。
//通过可空链式调用访问一个Int值，将会返回Int?，不过进行了多少次可空链式调用。
//类似的，通过可空链式调用访问Int?值，并不会变得更加可空。返回的依然是Int?

if let johnsStreet = john1.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john1.residence?.address = johnsAddress

if let johnsStreet = john1.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}


/************************** 对返回可空值的函数进行链接 *************/

if let buildingIdentifier = john1.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
if let beginsWithThe =
    john1.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
        if beginsWithThe {
            print("John's building identifier begins with \"The\".")
        } else {
            print("John's building identifier does not begin with \"The\".")
        }
}