
import UIKit
import CoreData
class ViewController: UIViewController {
    
    struct Constants {
        static let entity = "Person"
        static let sortName = "name"
        static let cellName = "Cell"
        static let identifier = "Cell"
    }
    var fetchResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entity)
        let sortDescriptor = NSSortDescriptor(key: Constants.sortName, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instantse.context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }()
    //Таблица
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
      return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .cyan
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        fetchResultController.delegate = self
        title = "WhatAreWeDoingInTheDark"
        navigationItem.rightBarButtonItem  = UIBarButtonItem(title: "Turn", style: .plain, target: self, action: #selector(addPersonal))
        //Убираем разлиновку пустых ячеек
        tableView.tableFooterView = UIView()
        //Делаем загоовок большим
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        for x in 1...100 {
//            dataTable.append("Some dataTable \(x)")
//        }
        let managedObject = Person()
        
        // Установка значений атрибутов
        managedObject.name = "Nudia"
        managedObject.age = 700
        
        // Извлекаем значения атрибутов
        let name = managedObject.name
        let age = managedObject.age
        print ("\(name), \(age)")
        // Сохранение данных в базу
        CoreDataManager.instantse.saveContext()
        //Извлекаем данные
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do {
            let results = try CoreDataManager.instantse.context.fetch(fetchRequest)
            // это массив
//            // поэтому делаем каждую строку отдельно через цикл
            for result in results as! [Person] {
                print("name -\(result.name),age -\(result.age)")
            }
        }
        catch {
            print(error)
        }
        // Делаем выборку из базы данных
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error)
        }
      // Удаление ВСЕХ днных
//        do {
//            let result = try CoreDataManager.instantse.context.fetch(fetchRequest)// это массив
//            // поэтому делаем каждую строку отдельно через цикл
//            for result in result as! [NSManagedObject] {
//                CoreDataManager.instantse.context.delete(result)
//            }
//    }
//        catch {
//        print(error)
//    }
//        // Сохранение изменений, и только тогда сработает удаление
//        CoreDataManager.instantse.saveContext()
}
    @objc func addPersonal () {
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    // Таблица
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Vampires"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellName, for: indexPath)
        let person = fetchResultController.object(at: indexPath) as! Person
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = String(person.age)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections?.count ?? 0
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = fetchResultController.object(at: indexPath) as! Person
            CoreDataManager.instantse.context.delete(person)
            CoreDataManager.instantse.saveContext()
        }
    }
    //Не удается реализовать метод редактирования по нажатию на ячейку(у автора сториборды)
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let person = fetchResultController.object(at: indexPath) as! Person
//        performSegue(withIdentifier: Constants.identifier, sender: person)
//    }
     
    //Методы отслеживания изменений в таблице. Без них изменения будут появляться только при перезапуске приложения.
    
    // 1.Информируем о начале изменения данных
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    // 2. Основной метод
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let person = fetchResultController.object(at: indexPath) as! Person
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = person.name
                cell?.detailTextLabel?.text = String(person.age)
            }
        default:
            break
        }
    }
    // 3.Информирует об окончании изменения данных
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
