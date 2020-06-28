
import UIKit
import CoreData

class SubjectTVC: UITableViewCell {
    
    @IBOutlet var subjectLbl: UILabel!
    @IBOutlet weak var editButtonOL: UIButton!
    
    var subjectData: SubjectsDB?{
        didSet{
         subjectLbl.text =  "\(subjectData?.title ?? "")"
        }
    }
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
