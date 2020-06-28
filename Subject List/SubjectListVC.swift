
import UIKit

protocol subjectDataPass {
    
    func passSubjectData(subjecttitle:String)
}

class SubjectListVC: UIViewController {
    
    //MARK:- Variable
    var Subjects = [SubjectsDB]()
    var delegate :subjectDataPass?
    
    //MARK:- OutLets
    @IBOutlet weak var subjectTblView: UITableView!
    
     //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.Subjects = DatabaseHelper.shareInstance.getAllSubjectData()
        self.subjectTblView.reloadData()
        self.subjectTblView.tableFooterView = UIView()
    }
}

// MARK: - Table view Delegate & Datasource

extension SubjectListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectTVC", for: indexPath) as! SubjectTVC
        cell.subjectData = Subjects[indexPath.row]
        
        cell.editButtonOL.tag = indexPath.row
        cell.editButtonOL.addTarget(self, action: #selector(self.btnCheck(_:)), for: .touchUpInside)
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         self.navigationController?.popViewController(animated: true)
        self.delegate?.passSubjectData(subjecttitle: Subjects[indexPath.row].title ?? "")
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.Subjects = DatabaseHelper.shareInstance.deleteSubjectData(index: indexPath.row)
            self.subjectTblView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
    @objc func btnCheck(_ sender: UIButton) {
        
        let SubjectDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewSubjectVC") as! AddNewSubjectVC
        SubjectDetailVC.subjectDetails = Subjects[sender.tag]
        SubjectDetailVC.indexRow = sender.tag
        SubjectDetailVC.isEditSubject = true
        self.navigationController?.pushViewController(SubjectDetailVC, animated: true)
        
    }
}
