
import Foundation
import CoreText

struct Lesson: Decodable {
    let id: Int
    let name: String
    let date: Date
    let imageLessons: String?
    let link: String
    //для варианта 5 с вложенностью
    let comments: [Comment]?
    
    
    // В том случае, когда необходимо изменить одно из свойств, то переписываем ЕНАМ, который по умолчанию есть под капотом, и меняем в нем, что нам нужно 
    enum CodyngKeys: String, CodingKey {
        case id
        case name
        case date
        case link
        case imageLessons = "image"
        case comments
    }
}
//Варинт 5 (С вложенностью)

struct Comment: Decodable {
    let id: Int
    let text: String
    let date: Date
    let user: User
}
struct User: Decodable {
    let id: Int
    let name: String
    let gender: Gender

enum Gender: String {
    case male
    case female
   }
}
