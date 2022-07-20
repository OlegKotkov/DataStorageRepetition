
import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    //Создаем сущность
    convenience init(){
        self.init(entity: CoreDataManager.instantse.entityForName(entityName: "Person"), insertInto: CoreDataManager.instantse.context)
    }
}
