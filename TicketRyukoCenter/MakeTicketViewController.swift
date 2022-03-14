//
//  MakeTicketViewController.swift
//  TicketRyukoCenter
//
//  Created by SeinaKonishi on 2022/03/07.
//

import UIKit
import Firebase
import RealmSwift

class MakeTicketViewController: UIViewController {
    
    let firestore = Firebase.Firestore.firestore()
    let realm = try! Realm()
    
    @IBOutlet var designCard1: UIButton!
    @IBOutlet var designCard2: UIButton!
    @IBOutlet var designCard3: UIButton!
    @IBOutlet var designCard4: UIButton!
    
    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var senderTextField:UITextField!
    @IBOutlet var comentTextField:UITextField!
    
    @IBOutlet var limitDatePicker: UIDatePicker!
    
    var titleText: String = ""
    var senderText: String = ""
    var comentText: String = ""
    var limitDateValue: Date = Date()
    var cardSelecte:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleTextField.setUnderLine()
        senderTextField.setUnderLine()
        comentTextField.setUnderLine()
        
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func pinkButton(){
        cardSelecte = 1
    }
    
    @IBAction func orangeButton(){
        cardSelecte = 2
    }
    
    @IBAction func greenButton(){
        cardSelecte = 3
    }
    
    @IBAction func blueButton(){
        cardSelecte = 4
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("こちらが早く呼び出されているとprepare")
        
        titleText = self.titleTextField.text!
        senderText = self.senderTextField.text!
        comentText = self.comentTextField.text!
        limitDateValue = self.limitDatePicker.date

         // segueのIDを確認して特定のsegueのときのみ動作させる
         if segue.identifier == "toSendViewController" {
             // 2. 遷移先のViewControllerを取得
             let next = segue.destination as? SendViewController
             // 3. １で用意した遷移先の変数に値を渡す
             next?.titleText = self.titleText
             next?.senderText = self.senderText
             next?.comentText = self.comentText
             next?.limitDate = limitDateValue
             next?.design = self.cardSelecte
             
         }
     }

     @IBAction func tapTransitionButton(_ sender: Any) {
         // 4. 画面遷移実行
         performSegue(withIdentifier: "toSendViewController", sender: nil)
     }
    
    @IBAction func tapToSaveAndSendData(){
        
        print("こちらが早く呼び出されているとIBAction")
        
        sendDataToFirebase()
        saveCardDatatoRealm()
        
    }
    
    func sendDataToFirebase(){
        
        let cardData = [
            
            "cardTitle": titleTextField.text!,
            "cardSender": senderTextField.text!,
            "cardComent": comentTextField.text!,
            "cardLimit": limitDatePicker.date,
            "cardDesign": cardSelecte,
            
        ] as [String : Any]

        //firestore.collection("cards").addDocument(data: cardData)
        firestore.collection("cards").document("ここにIDを入れる").setData(cardData){ err in
            if let err = err {
                print("送信できませんでした: \(err)")
            }
        }
        
        
       // firestore.collection("cards").document("cardInfo").setData(["cardTitle": titleTextField.text!])
    }
    
    func saveCardDatatoRealm(){
        
        let cardSave: RecaiveCard? = read()
    
        try! realm.write{
            
            cardSave!.title = titleTextField.text!
            cardSave!.sender = senderTextField.text!
            cardSave!.limit = limitDatePicker.date
            cardSave!.coment = comentTextField.text!
            cardSave!.design = cardSelecte
            
        }
    }
    
    func read() -> RecaiveCard?{
        return realm.objects(RecaiveCard.self).first
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

extension UITextField {
    func setUnderLine() {
        // 枠線を非表示にする
        borderStyle = .none
        let underline = UIView()
        // heightにはアンダーラインの高さを入れる
        underline.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: 0.5)
        // 枠線の色
        underline.backgroundColor = .gray
        addSubview(underline)
        // 枠線を最前面に
        bringSubviewToFront(underline)
    }
}
