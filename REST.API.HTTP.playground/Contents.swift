import UIKit


var urlComponents = URLComponents()
urlComponents.scheme = "http"
urlComponents.host = "jsonplaceholder.typicode.com"
urlComponents.path = "/comments"

urlComponents.queryItems = [URLQueryItem(name: "postId", value: "1")], [URLQueryItem(name: "limit", value: "5")]
guard let url = urlComponents.url else {return}
URLSession.shared.dataTask(with: url) { data, response, error in
    print(error ?? "no error")
}
        
