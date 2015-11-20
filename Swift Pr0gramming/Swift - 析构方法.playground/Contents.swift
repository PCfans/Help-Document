//: Playground - noun: a place where people can play

import UIKit

/*
/************************** 析构过程（Deinitialization）   *************=/
**************/
*/
//析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用
//Swift 会自动释放不再需要的实例以释放资源，通常当你的实例被释放时不需要手动地去清理
//但是，当使用自己的资源时，你可能需要进行一些额外的清理。例如，如果创建了一个自定义的类来打开一个文件，并写入一些数据，你可能需要在类实例被释放之前手动去关闭该文件。
//在类的定义中，每个类最多只能有一个析构器，而且析构器不带任何参数
//析构器是在实例释放发生前被自动调用。析构器是不允许被主动调用的
//子类继承了父类的析构器，并且在子类析构器实现的最后，父类的析构器会被自动调用。即使子类没有提供自己的析构器，父类的析构器也同样会被调用
//直到实例的析构器被调用时，实例才会被释放所以析构器可以访问所有请求实例的属性，并且根据那些属性可以修改它的行为（比如查找一个需要被关闭的文件）


/************************** 析构器操作   *************/
struct Bank {
    static var coinsInBank = 10_000
    static func vendCoins(var numberOfCoinstoVend: Int) -> Int{
        numberOfCoinstoVend = min(numberOfCoinstoVend, coinsInBank)
        coinsInBank -= numberOfCoinstoVend
        return numberOfCoinstoVend
    }
    static func receiveCoins(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int){
        coinsInPurse = Bank.vendCoins(coins)
    }
    func winCoins(coins: Int){
        coinsInPurse += Bank.vendCoins(coins)
    }
    deinit{
        Bank.receiveCoins(coinsInPurse)
    }
}

var playone:Player? = Player(coins: 100)
print("A new player has joined the game with \(playone!.coinsInPurse) coins")
playone!.winCoins(2_000)
playone = nil
print("The bank now has \(Bank.coinsInBank) coins")
