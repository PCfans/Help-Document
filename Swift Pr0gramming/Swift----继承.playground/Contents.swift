//: Playground - noun: a place where people can play

import UIKit

/*
/************************** 继承（Inheritance）   *************=/
**************/
*/
//在 Swift 中，继承是区分「类」与其它类型的一个基本特征。
//可以为类中继承来的属性添加属性观察器（property observers），这样一来，当属性值改变时，类就会被通知到


/************************** 定义一个基类   *************/
//不继承于其它类的类，称之为基类（base calss）

class Vehicle {
    var currentSpeed = 0.0
    var description: String{
        return  "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise(){
        
    }
}
let someVehicle = Vehicle()

/************************** 子类  *************/
class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")


/************************** 重写  *************/
//访问超类的方法，属性及下标脚本 (super)
//重写方法

class Train: Vehicle {
    override func makeNoise() {
        print("coo coo")
    }
}
//重写属性
//重写属性的setter  getter
//你在重写一个属性时，必需将它的名字和类型都写出来
//你可以将一个继承来的只读属性重写为一个读写属性，你可以将一个继承来的只读属性重写为一个读写属性
//如果你在重写属性中提供了 setter，那么你也一定要提供 getter。也可以直接通过super.someProperty来返回继承来的值

class CCar: Vehicle {
    override var description:String{
        get{
           return super.description
        }
        set{
            self.currentSpeed = 100
        }
    }
}
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
let car = CCar()
car.currentSpeed = 25.0
car.description = "hah"
//car.gear = 3
print("Car: \(car.description)")

//重写属性观察器
//不可以为继承来的常量存储型属性或继承来的只读 (计算型) 属性添加属性观察器,这些属性的值是不可以被设置的
//不可以同时提供重写的 setter 和重写的属性观察器

class AutomaticCar: Car {
    override var currentSpeed : Double{
        didSet{
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")


/************************** 防止重写  *************/
//把方法，属性或下标脚本标记为final来防止它们被重写

class Vehicle1 {
    final var currentSpeed = 0.0
    final var description: String{
      return  "traveling at \(currentSpeed) miles per hour"
    }
    final func makeNoise(){
        
    }
}