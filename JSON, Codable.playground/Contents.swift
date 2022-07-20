import UIKit
import Darwin

struct User: Decodable {
    let userID: Int
    let Id: Int
    let title: String
    let body: String
    
    //Если не совпадают поля, то есть специальный механизм - Enum Нужно подписать на специальный протокол CodingKeys:
    enum CodingKeys: String, CodingKeys {
        case userID
        case numberID = "Id"// Это как раз пример
        case title
        case body   
    }
    
    
}
 //Создаем ЮРЛ с помощью строкиC
if let url = URL(string: "http://jsonplaceholder.typicode.com/posts/1") {
    
//Вызываем сессию и создаем DataTask
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let unwreppedData = data {
            do {
                let user = try JSONDecoder().decode(User.self, from: unwreppedData)
                print(user.body)
            }
            catch let error {
                print(error)
            }
        }
    }
}
