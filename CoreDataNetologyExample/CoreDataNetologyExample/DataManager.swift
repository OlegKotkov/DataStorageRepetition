
import Foundation
import UIKit
import CoreData

class DataBaseManager {
    static let shared = DataBaseManager()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: "DataModel", withExtension: "momd") else {
            fatalError("Unable for Find DataModel")
    }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
    }
    return managedObjectModel
}()
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let documentsDirectoryURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        print(documentsDirectoryURL)
         let storeName = "DataBaseModel123.sqLite"
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: nil)
        }
        catch {
           fatalError("Unable to load persistent Store")
        }
        return persistentStoreCoordinator
       }()
       private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    func getLaunchesNumber() -> {
        let fetchRequest = Entity.fetchRequest()
        do {
            let settings = try managedObjectContext.fetch(fetchRequest)
            if let set = settings.first {
                return Int (truncatingIfNeeded: set.Entity)
            }
            else return 0
        }
        catch let error {
           print(error)
        }
    }
    //Вызов происходит в контроллере DataBaseManager
    // и в инициализаторе:
    init () {
        _  = persistentStoreCoordinator
    }
    

    
}
