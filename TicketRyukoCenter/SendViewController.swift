//
//  SendViewController.swift
//  TicketRyukoCenter
//
//  Created by SeinaKonishi on 2022/03/07.
//

import UIKit

class SendViewController: UIViewController {
    
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var senderLabel:UILabel!
    @IBOutlet var comentLabel:UILabel!
    @IBOutlet var limitdayLabel:UILabel!
    
    @IBOutlet var idTextField:UITextField!
    
    @IBOutlet var sendButton:UIButton!
    
    var titleText:String = ""
    var senderText:String = ""
    var comentText:String = ""
    var limitDate:Date = Date()
    var design:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
