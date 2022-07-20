

import Foundation

 // Cоздаем юрл с помощью строки
if let url = URL(string: "http://google.com") {
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        print("Server's response is \(response.debugDescription)")
        // функция Шеред - это то же самое что URLSessionConfiguration.default
        // Но там есть не только дефолт, поэтому можно переопределить что-нибудь при желании
        
        
        //Пример того , как можно сделать сессию только через WIFI
        // тут при отсутсвии вайфая будет приходить ошибка и запрос никуда не уйдет
        let wifiSessionConfiguration = URLSessionConfiguration.default
        wifiSessionConfiguration.timeoutIntervalForResource = 10
        wifiSessionConfiguration.allowsCellularAccess = false
        
        //Создаем запрос по-правильному через URLRequest
        
        let urlRequest = URLRequest(url: url)
        urlRequest.setValue("Google Chrome", forHTTPHeaderField: "X-client")
        let task = session.dataTask(with: urlRequest) { data,response, error in
            print ("Server's response is \(response.debugDescription)")
        }
    }
    task.resume()
} else {
    print("can not create URL")
}
