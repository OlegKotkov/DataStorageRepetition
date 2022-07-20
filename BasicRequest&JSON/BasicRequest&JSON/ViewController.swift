
import UIKit
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        makeReqest()
    }
    private func makeReqest(){
        let urlString = "http://v2.jokeapi.dev/joke/Any"
        guard let url = URL(string: urlString) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = ["authToken": "nil"]
        urlRequest.httpMethod = "Get"
        let task = URLSession.shared.dataTask(with: urlRequest) { data, responce, error in
            if let error = error {
                print(error)
                return
            }
            //Вызов для самого базового варианта
//            if let data = data {
//                print(String(decoding: data, as: UTF8.self))
//                return
//            }
            guard let data = data else {
                return
            }
            do {
               let decoder = JSONDecoder()
                let json = try decoder.decode(Joke.self, from: data)
                print(json.joke)
                
            } catch{
                print(error)
            }
        }
        task.resume()
    }
}

