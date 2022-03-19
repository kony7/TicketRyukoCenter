//
//  MakeTicketViewController.swift
//  TicketRyukoCenter
//
//  Created by SeinaKonishi on 2022/03/07.
//

import UIKit
import Firebase
import RealmSwift

class MakeTicketViewController: UIViewController, UITextFieldDelegate {
    
    //firebaseとrealmのインスタンス化
    let firestore = Firebase.Firestore.firestore()
    let realm = try! Realm()
    
    //発券番号になるUUID(IDを自動で発行してくれる関数かな？)を宣言
    let uuid = UUID()

    //カードのデザインを選ぶボタンの宣言
    @IBOutlet var designCard1: UIButton!
    @IBOutlet var designCard2: UIButton!
    @IBOutlet var designCard3: UIButton!
    @IBOutlet var designCard4: UIButton!
    
    //タイトル・送信者・コメント・期限を入力するテキストフィールドとDataPickerの宣言
    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var senderTextField:UITextField!
    @IBOutlet var comentTextField:UITextField!
    @IBOutlet var limitDatePicker: UIDatePicker!
    
    //入力されたタイトル・送信者・コメント・期限・カードデザイン・発券番号を一時的に保存する変数の宣言
    var titleText: String = ""
    var senderText: String = ""
    var comentText: String = ""
    var limitDateValue: Date = Date()
    var cardSelecte:Int = 0
    var tickedtID: String = ""
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //テキストフィールドを下線だけのデザインに変更
        titleTextField.setUnderLine()
        senderTextField.setUnderLine()
        comentTextField.setUnderLine()
        
        titleTextField.delegate = self
        senderTextField.delegate = self
        comentTextField.delegate = self
        
    }
    

    //カードを押したらそのデザインの変数が保存されるようにする
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
    
    //画面遷移の前に準備するもの
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //発券番号の発行
        tickedtID = uuid.uuidString
        
        //テキストフィールドに入力されている内容などを変数に代入する関数
        textFieldToValue()

         // segueのIDを確認して特定のsegueのときのみ動作させる
         if segue.identifier == "toSendViewController" {
             
             //遷移先のViewControllerを取得
             let next = segue.destination as? SendViewController
             
             //遷移先の変数に値を渡す
             next?.titleText = self.titleText
             next?.senderText = self.senderText
             next?.comentText = self.comentText
             next?.limitDate = limitDateValue
             next?.design = self.cardSelecte
             next?.cardID = self.tickedtID
             
         }
     }

    //prepareから呼ばれるやつ
     @IBAction func tapTransitionButton(_ sender: Any) {
         
         //画面遷移実行
         performSegue(withIdentifier: "toSendViewController", sender: nil)
         
     }
    
    //Firebaseへの保存とRealmへの保存をボタンに紐づけるためのメソッド
    @IBAction func tapToSaveAndSendData(){
        
        sendDataToFirebase()
        saveCardDatatoRealm()
        
    }
    
    //Firebaseにデータを送るためのメソッド
    func sendDataToFirebase(){
        
        //テキストフィールドに入力されている内容などを変数に代入する関数
        textFieldToValue()
        
        //Firebaseに送るために配列型に変更
        let cardData = [
            
            "cardTitle": titleText,
            "cardSender": senderText,
            "cardComent": comentText,
            "cardLimit": limitDateValue,
            "cardDesign": cardSelecte,
            
        ] as [String : Any]

        //documentIDをこちらで発行したUUIDに設定
        firestore.collection("cards").document(tickedtID).setData(cardData){ err in
            if let err = err {
                print("送信できませんでした: \(err)")
            }
        }
    }
    
    
    //Realmにデータを保存する関数
    func saveCardDatatoRealm(){
        
        //テキストフィールドに入力されている内容などを変数に代入する関数
        textFieldToValue()
               
        //Realmのクラスの型で新しい定数を宣言し、それぞれに入力した値を代入
        let newCard = RecaiveCard()
        newCard.title = titleText
        newCard.sender = senderText
        newCard.limit = limitDateValue
        newCard.coment = comentText
        newCard.design = cardSelecte
                      
        //代入した値をRealmに追加
        try! realm.write{
              
            realm.add(newCard)
                  
            }
        }
    
    //テキストフィールドに入力されている内容などを変数に代入する関数
    func textFieldToValue(){
        
        //もしテキストフィールドの内容が空だったらアラートを鳴らしそれ以外の場合にFirebaseにデータを送る
        if titleTextField.text == nil && titleTextField.text == ""{
            
            getAlert(alertTitleText: "タイトルが入力されていません")
            return
            
        }else if senderTextField.text == nil && titleTextField.text == ""{
            
            getAlert(alertTitleText: "送信者が入力されていません")
            return
            
        }else{
        
        titleText = self.titleTextField.text!
        senderText = self.senderTextField.text!
        comentText = self.comentTextField.text!
        limitDateValue = self.limitDatePicker.date
            
        }
    }
    
    //アラートを鳴らす関数
    func getAlert(alertTitleText:String){
        
        //アラートのタイトルには引数を出力し、メッセージにはアラートが出ている原因を出力
        let alert = UIAlertController(title: alertTitleText, message: "必須の項目が入力されていません", preferredStyle: .alert)
        
        //ボタンは戻るボタンを設定
        let cancel = UIAlertAction(title: "戻る", style: .cancel) { (acrion) in
            self.dismiss(animated: true, completion: nil)
        }
        
        //アラートを上記で設定した内容で出す
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    //テキストフィールドに入力中、キーボードでReturnボタンが押されるとキーボードが終われるメソッド
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
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

//テキストフィールドを下線だけにする関数
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
