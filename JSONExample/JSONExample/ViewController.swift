
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        //Для первых вариантов
        //let urlString = "https://icodeschool.ru/json1.php"
        // Для варианта 5
        let urlString = "https://icodeschool.ru/json2.php"
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {return}
// 1. Вариантю Просто передаем строку в запрос
            
//            let jsonString = String(data: data, encoding: .utf8)
//            print(jsonString)
            
// 2. Вариант - Распарсить
            

            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let lessons = try decoder.decode([Lesson].self, from: data)
                print(lessons.first?.comments?.first?.user.name)
            } catch {
                print(error)
            }
            
// 3. Вариант ..... Это где меняем тип данных
                        
// 4. Вариан Изменение имени одного из свойств структура. Переписываем ЕНАМ - см. Модель
                        
// 5. Вариант Когда в внутри JSON -> JSON В данном случае комментарий к уроку и пользователь котоый написал его - Вложенность
        }
        .resume()
        
    }


}

