
import UIKit
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        let manager = FileManager.default
        guard let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        // Распечатав это, мы получаем путь к папке в симуляторе(пустая). Открываем терминал, пишем оупен пробел и этот адрес -> видим пустой каталог
         print(url.path)
        
        // создаем папку
        let newFolderUrl = url.appendingPathComponent("IosStady")
        do {
           try manager.createDirectory(at: newFolderUrl,
                                        withIntermediateDirectories: true,
                                        attributes: [:])
        }
        catch {
            print(error)
        }
        // Создаем папку для удаления
        let fileForDel = url.appendingPathComponent("WillDelete")
        do {
            try manager.createDirectory(at: fileForDel,
                                        withIntermediateDirectories: true,
                                        attributes: [:])
        }
        catch {
            print(error)
        }
        // Удаляем папку
        let fileURLDel = url.appendingPathComponent("WillDelete")
        if manager.fileExists(atPath: fileURLDel.path){
            do {
                try manager.removeItem(at: fileURLDel)
            }
            catch {
                print(error)
            }
        }
        //Создаем еще папку и подпапку
        let secondSubFolder = url.appendingPathComponent("SubCataloge").appendingPathComponent("subSubCataloge")
        do {
            try manager.createDirectory(at: secondSubFolder,
                                        withIntermediateDirectories: true,
                                        attributes: [:])
        }
        catch {
           print(error)
        }
        // Создаем текстовый файл внутри первой папки
        let fileURL = newFolderUrl.appendingPathComponent("logs.txt")
        // Создаем текст внутри документа
        let data = "Пошел на хуй!!!!!!!!!!!".data(using: .utf8)
        do {
            try manager.createFile(atPath: fileURL.path,
                                   //contents: nil,
                                   contents: data,
                                   attributes: [FileAttributeKey.creationDate : Date()])
        }
        catch {
            print(error)
        }
    }
}

