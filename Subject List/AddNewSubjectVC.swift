
import UIKit

class AddNewSubjectVC: UIViewController {
    
    // MARK: - Variable
    
    var isEditSubject = Bool()
    var indexRow = Int()
    var subjectDetails: SubjectsDB?
    
    // MARK: - Outlets
    @IBOutlet weak var subjectTxtFld: UITextField!
    @IBOutlet weak var addSubjectBtnOL: UIButton!
    
     // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.subjectTxtFld.setLeftPaddingPoints(20)
         self.subjectTxtFld.text = subjectDetails?.title

        
        // set button title
        if isEditSubject {
             addSubjectBtnOL.setTitle("Save Subject", for: .normal)
        }else{
            addSubjectBtnOL.setTitle("Add Subject", for: .normal)
        }
        
    }
    
     // MARK: - Button Action
    @IBAction func AddNewSubjectBtnAction(_ sender: Any) {
        
        let subjectStr  = self.subjectTxtFld.text ?? ""
        if  subjectStr.trim().count > 0 {
            let subjectData = ["subjectName": subjectStr.trim()]
            if isEditSubject {
                DatabaseHelper.shareInstance.editSubjectData(SubjectDict: subjectData, index: indexRow)
                isEditSubject = false
                 
            }else{
                DatabaseHelper.shareInstance.saveSubjectData(SubjectDict: subjectData)
            }
               
             self.navigationController?.popViewController(animated: true)
        } else {
            showAlertDialog(title: "Please Enter Subject Name")
        }
    }
    
}
