//: Playground - noun: a place where people can play

import UIKit

/*
/************************** 嵌套类型  *************=/
**************/
*/
//Swift允许你定义嵌套类型，可以在枚举类型、类和结构体中定义支持嵌套的类型。

//BlackjackCard结构体包含2个嵌套定义的枚举类型Suit 和 Rank。
struct BlackJackCard{
       // 嵌套定义枚举型Suit
    enum Suit: Character{
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    // 嵌套定义枚举Rank
    enum Rank: Int{
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        
        struct Values {
            let first: Int, second: Int?
        }
        
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard 的属性和方法
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

let theAceOfSpades = BlackJackCard(rank: .Ace, suit: .Spades)
print("theAceOfSpades: \(theAceOfSpades.description)")


let heartsSymbol = BlackJackCard.Suit.Hearts.rawValue