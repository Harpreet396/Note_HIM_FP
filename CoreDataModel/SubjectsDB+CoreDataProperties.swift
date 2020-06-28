

import Foundation
import CoreData


extension SubjectsDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubjectsDB> {
        return NSFetchRequest<SubjectsDB>(entityName: "SubjectsDB")
    }

    @NSManaged public var title: String?

}
