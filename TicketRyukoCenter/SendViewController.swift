//
//  SendViewController.swift
//  TicketRyukoCenter
//
//  Created by SeinaKonishi on 2022/03/07.
//

import UIKit
import Firebase

class SendViewController: UIViewController {
    
    let firestore = Firebase.Firestore.firestore().collection("cards")
    
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var senderLabel:UILabel!
    @IBOutlet var comentLabel:UILabel!
    @IBOutlet var limitdayLabel:UILabel!
    
    @IBOutlet var idTextField:UITextField!
    
    @IBOutlet var cardImageView:UIImageView!
    
    @IBOutlet var sendButton:UIButton!
    
    var titleText:String = ""
    var senderText:String = ""
    var comentText:String = ""
    var limitDate:Date = Date()
    var design:Int = 0
    var cardidArray:[String] = [""]

    override func viewDidLoad() {
        super.viewDidLoad()


        // Create a query against the collection.
        let query = firestore.whereField(document.documentID, isEqualTo: titleText)
        
        firestore.getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    self.cardidArray.append(document.documentID)
                    print("これはカードidです→" + self.cardidArray.last!)
                    // Do something.
                }
            }
        }

        idTextField.text = cardidArray.last!
        
        switch design{
        case 1:
            cardImageView.image = UIImage(named: "TicketCardPink")
        case 2:
            cardImageView.image = UIImage(named: "TicketCardOrange")
        case 3:
            cardImageView.image = UIImage(named: "TicketCardGreen")
        case 4:
            cardImageView.image = UIImage(named: "TicketCardBlue")
        default:
            return
            
        }
        
        titleLabel.text = titleText
        senderLabel.text = senderText
        comentLabel.text = comentText
       // limitdayLabel.text = String(limitDate)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
