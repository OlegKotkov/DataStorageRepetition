
import Foundation

struct Result: Codable {
    let data: [ResultItems]
}
struct ResultItems: Codable {
    let title: String
    let items: [String]
}
