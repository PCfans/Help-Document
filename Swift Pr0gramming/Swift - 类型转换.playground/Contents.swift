//: Playground - noun: a place where people can play

import UIKit

/*
/************************** 类型转换（Type Casting）  *************=/
**************/
*/
//类型转换 可以判断实例的类型，也可以将实例 看做是其父类 或 子类 的实例
//类型转换在 Swift 中使用 is 和 as 操作符实现
//你也可以用它来检查一个类是否实现了某个协议


/**************************     定义一个类层次作为例子  *************/

class MediaItem {
    var name: String
    init(name: String){
        self.name = name
    }
}
class Movie: MediaItem {
    var director: String
    init(name: String, director: String){
        self.director = director
        super.init(name: name)
    }
}
class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]


/**************************   检查类型（Checking Type）  *************/
//用类型检查操作符(is)来检查一个实例是否属于特定子类型。若实例属于那个子类型，类型检查操作符返回 true，否则返回 false。

var moviceCount = 0
var songCount = 0

for item in library{
    if item is Movie {
        ++moviceCount
    }else if item is Song {
        ++songCount
    }
}
print("Media library contains \(moviceCount) movies and \(songCount) songs")


/**************************  向下转型（  *************/
//某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符(as? 或 as!)
//因为向下转型可能会失败，类型转型操作符带有两种不同形式。
//as? 返回一个你试图向下转成的类型的可选值
//只有你可以确定向下转型一定会成功时，才使用强制形式(as!)。当你试图向下转型为一个不正确的类型时，强制形式的类型转换会触发一个运行时错误。

for item in library{
    if let movie = item as? Movie{
        print("Movie: '\(movie.name)', dir. \(movie.director)")
    }else if let song = item as? Song{
        print("Song: '\(song.name)', by \(song.artist)")
    }
}


/**************************  Any和AnyObject的类型转换  *************/

//Swift为不确定类型提供了两种特殊类型别名
//AnyObject可以代表任何class类型的实例。
//Any可以表示任何类型，包括方法类型（function types）

let someObjects: [AnyObject] = [
    Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
    Movie(name: "Moon", director: "Duncan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]
for object in someObjects {
    let movie = object as! Movie
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}
//简短形式
for movie in someObjects as! [Movie] {
    print("Movie: '\(movie.name)', dir. \(movie.director)")
}

var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called '\(movie.name)', dir. \(movie.director)")
    case let stringConverter as String -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}
