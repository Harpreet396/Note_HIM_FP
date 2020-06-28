
import Foundation
import UIKit
import CoreData




extension UIViewController {
    
    
    func showAlertDialog(title:String) {
        let alert = UIAlertController(title: "Error!", message: title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "okay", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}


extension String
{
    func trim() -> String
   {
    return self.trimmingCharacters(in: CharacterSet.whitespaces)
   }
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
