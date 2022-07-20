
import UIKit
import CoreData
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        let managedObject = Person()
        //Установка значений атрибута
        managedObject.name = "Jonh"
        managedObject.age = 1000
        //Извлекаем значение атрибута
        let name = managedObject.name
        let age = managedObject.age
        print("\(name),  \(age)")
        //Сохранение данных
        CoreDataManager.instantse.saveContext()
        //Извлекаем данные
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instantse.context.fetch(fetchRequest)

            for result in results as! [Person] {
                print("name - \(result.name), age - \(result.age) ")
            }
        }
        catch {
            print(error)
        }
        //Удаление ВСЕХ!!! данных
       do {
            let result = try CoreDataManager.instantse.context.fetch(fetchRequest)
           // это массив
           // поэтому делаем каждую строку отдельно через цикл
            for result in result as! [NSManagedObject] { CoreDataManager.instantse.context.delete(result)
           }
    }
        catch { print(error)
    }
        CoreDataManager.instantse.saveContext()
}
}
