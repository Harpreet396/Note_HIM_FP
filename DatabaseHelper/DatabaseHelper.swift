
import UIKit
import CoreData

class DatabaseHelper: NSObject {

    static let shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //MARK:-  NOTES DB Methods
    
    func saveNotesData(NotesDict: [String:Any]){
        let notes = NSEntityDescription.insertNewObject(forEntityName: "NotesDB", into: context) as! NotesDB
        notes.title = NotesDict["title"] as? String ?? ""
        notes.text = NotesDict["text"] as? String ?? ""
        notes.subject = NotesDict["subject"] as? String ?? ""
        notes.address = NotesDict["address"] as? String ?? ""
        notes.cellName = NotesDict["cellName"] as? String ?? ""
        notes.imageData = NotesDict["imageData"] as? Data ?? Data()
        notes.lat = NotesDict["lat"] as? String ?? ""
        notes.long = NotesDict["long"] as? String ?? ""
       
        
        do{
            try context.save()
        }catch let err{
            print("Notes save error :- \(err.localizedDescription)")
        }
    }
    
    func getAllNotesData() -> [NotesDB]{
        var arrNotes = [NotesDB]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NotesDB")
        do{
            arrNotes = try context.fetch(fetchRequest) as! [NotesDB]
        }catch let err{
            print("Error in Subject fetch :- \(err.localizedDescription)")
        }
        return arrNotes
    }
    
    func deleteNotesData(index: Int) -> [NotesDB]{
        var NotesData = self.getAllNotesData() // GetData
        context.delete(NotesData[index]) // Remove From Coredata
        NotesData.remove(at: index) // Remove in array Notes
        do{
            try context.save()
        }catch let err{
            print("delete Notes data :- \(err.localizedDescription)")
        }
        return NotesData
    }
    
    func editNotesData(NotesDict: [String : Any], index:Int , searchText : String){
        
        let Notes = (searchText == "") ? self.getAllNotesData() : self.GetFilteredData(searchText: searchText)
    // original data
        Notes[index].title = NotesDict["title"] as? String ?? ""
        Notes[index].text = NotesDict["text"] as? String ?? ""
        Notes[index].subject = NotesDict["subject"] as? String ?? ""
        Notes[index].address = NotesDict["address"] as? String ?? ""
        Notes[index].cellName = NotesDict["cellName"] as? String ?? ""
        Notes[index].imageData = NotesDict["imageData"] as? Data ?? Data()
        Notes[index].lat = NotesDict["lat"] as? String ?? ""
        Notes[index].long = NotesDict["long"] as? String ?? ""
               
        do{
            try context.save()
        }catch{
            print("error in edit data")
        }
    }
    
    func GetFilteredData(searchText : String) -> [NotesDB]{
    
        var arrNotes = [NotesDB]()
        let myRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesDB")
        myRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)

        do{
            arrNotes = try context.fetch(myRequest) as! [NotesDB]

        } catch let error{
            print(error)
        }
        
        return arrNotes
    }
    
    
/*========================================================================================================================================*/
    
    
    //MARK:- SUBJECTSDB Methods
    
    func saveSubjectData(SubjectDict: [String:String]){
        let Subject = NSEntityDescription.insertNewObject(forEntityName: "SubjectsDB", into: context) as! SubjectsDB
        Subject.title = SubjectDict["subjectName"]
        
        do{
            try context.save()
        }catch let err{
            print("Subjects save error :- \(err.localizedDescription)")
        }
    }
    
    func getAllSubjectData() -> [SubjectsDB]{
        var arrSubject = [SubjectsDB]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SubjectsDB")
        do{
            arrSubject = try context.fetch(fetchRequest) as! [SubjectsDB]
        }catch let err{
            print("Error in Subject fetch :- \(err.localizedDescription)")
        }
        return arrSubject
    }
    
    func deleteSubjectData(index: Int) -> [SubjectsDB]{
        var SubjectData = self.getAllSubjectData() // GetData
        context.delete(SubjectData[index]) // Remove From Coredata
        SubjectData.remove(at: index) // Remove in array Subject
        do{
            try context.save()
        }catch let err{
            print("delete Subject data :- \(err.localizedDescription)")
        }
        return SubjectData
    }
    
    func editSubjectData(SubjectDict: [String : String], index:Int){
        let Subject = self.getAllSubjectData()
    // original data
        Subject[index].title = SubjectDict["subjectName"] // edit data
        do{
            try context.save()
        }catch{
            print("error in edit data")
        }
    }
    
    
    
    
    
    
    
}
