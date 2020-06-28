
import UIKit
import CoreLocation
import MapKit


class NotesListVC: UIViewController,UISearchBarDelegate {
    
    //MARK:- Variable
       var Notes = [NotesDB]()
    var searchString = String()
    
      // var delegate :subjectDataPass?
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var searchbarheight: NSLayoutConstraint!
    @IBOutlet weak var listSearchBar: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.Notes = DatabaseHelper.shareInstance.getAllNotesData()
        self.tblView.reloadData()
        self.tblView.tableFooterView = UIView()
        
        self.tblView.rowHeight = UITableView.automaticDimension;
        self.tblView.estimatedRowHeight = 44.0;
        listSearchBar.delegate = self
        
        if self.Notes.count > 0 {
            self.searchbarheight.constant = 50
        }else{
            self.searchbarheight.constant = 0
        }
        
       }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        
        searchString = searchText
        
        if searchText != "" {
            self.Notes = DatabaseHelper.shareInstance.GetFilteredData(searchText:searchText)
        }else{
            self.Notes = DatabaseHelper.shareInstance.getAllNotesData()
        }
        
        
        self.tblView.reloadData()
        self.tblView.tableFooterView = UIView()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
    
        self.Notes = DatabaseHelper.shareInstance.getAllNotesData()
        self.tblView.reloadData()
        self.tblView.tableFooterView = UIView()
    }

}


// MARK: - Table view Delegate & Datasource

extension NotesListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTVC", for: indexPath) as! NotesTVC
        cell.subjectNameLbl.text = Notes[indexPath.row].subject
        cell.notesTitleLbl.text = Notes[indexPath.row].title
        cell.descLbl.text = Notes[indexPath.row].text
        cell.addressLbl.text = Notes[indexPath.row].address
        cell.notesImgVW.image = UIImage(data: Notes[indexPath.row].imageData!)
        
        cell.notesImgVW.layer.cornerRadius = cell.notesImgVW.frame.size.height/2
        cell.notesImgVW.clipsToBounds = true
        
        
        cell.editBtnAction.tag = indexPath.row
        cell.editBtnAction.addTarget(self, action: #selector(self.btnCheck(_:)), for: .touchUpInside)
        
        cell.viewmapBtnAction.tag = indexPath.row
        cell.viewmapBtnAction.addTarget(self, action: #selector(self.showMap(_:)), for: .touchUpInside)
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // self.navigationController?.popViewController(animated: true)
        //self.delegate?.passSubjectData(subjecttitle: Subjects[indexPath.row].title ?? "")
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.Notes = DatabaseHelper.shareInstance.deleteNotesData(index: indexPath.row)
            self.tblView.deleteRows(at: [indexPath], with: .top)
            
            if self.Notes.count > 0 {
                self.searchbarheight.constant = 50
            }else{
                self.searchbarheight.constant = 0
            }
        }
    }
    
    @objc func btnCheck(_ sender: UIButton) {
        let editnotesVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        editnotesVC.editindexRow = sender.tag
        editnotesVC.notesDetail = self.Notes[sender.tag]
        editnotesVC.sendingSearchString = searchString
        editnotesVC.isEditNotes = true
        editnotesVC.notesTakenCord = CLLocationCoordinate2D(latitude: Double(Notes[sender.tag].lat!)! , longitude: Double(Notes[sender.tag].long!)! )
        self.navigationController?.pushViewController(editnotesVC, animated: true)
        
    }
    
    @objc func showMap(_ sender: UIButton) {
           
        let MapVC = self.storyboard?.instantiateViewController(withIdentifier: "MapViewControler") as! MapViewControler
        
        MapVC.notesCord = CLLocationCoordinate2D(latitude: Double(Notes[sender.tag].lat!)! , longitude: Double(Notes[sender.tag].long!)! )
            self.navigationController?.pushViewController(MapVC, animated: true)
            
        }
}
