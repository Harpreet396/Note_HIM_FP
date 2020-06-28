

import Foundation
import CoreData


extension NotesDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotesDB> {
        return NSFetchRequest<NotesDB>(entityName: "NotesDB")
    }

    @NSManaged public var address: String?
    @NSManaged public var subject: String?
    @NSManaged public var cellName: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var lat: String?
    @NSManaged public var long: String?
    @NSManaged public var text: String?
    @NSManaged public var title: String?

}
