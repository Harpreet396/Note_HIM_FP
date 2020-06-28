
import UIKit

class NotesTVC: UITableViewCell {

    @IBOutlet weak var notesImgVW: UIImageView!
    @IBOutlet weak var subjectNameLbl: UILabel!
    @IBOutlet weak var notesTitleLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var editBtnAction: UIButton!
    @IBOutlet weak var viewmapBtnAction: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
