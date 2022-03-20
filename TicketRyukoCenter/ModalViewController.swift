//
//  ModalViewController.swift
//  TicketRyukoCenter
//
//  Created by SeinaKonishi on 2022/03/15.
//

import Foundation
import UIKit
import Firebase
import RealmSwift

/// UISheetPresentationController に載せたい ViewController
final class ModalViewController: UIViewController, UITextFieldDelegate {
    
    //firebaseとrealmのインスタンス化
    let firestore = Firebase.Firestore.firestore()
    let realm = try! Realm()
    
    //発券番号を入れるテキストフィールドの宣言
    @IBOutlet var idTextField:UITextField!
    
    //発券番号を一時的に保存する変数
    var ticketID:String = ""
    
    //チケットの内容を一時的に保存する変数
    var titleText: String = ""
    var senderText: String = ""
    var comentText: String = ""
    var limitDateValue: Date = Date()
    var cardSelecte:Int = 0

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //テキストフィールドを下線だけのデザインに変更
        idTextField.setUnderLine()
        
        idTextField.delegate = self
    }
    
    //発券ボタンを押した時の関数
    @IBAction func getTicketButton(){
        
        //テキストフィールドに入力されたIDを変数に代入
        if idTextField.text == nil && idTextField.text == ""{
            getAlert(alertTitleText: "IDが入力されていません")
        }else{
            ticketID = idTextField.text!
        }
        
        //代入されたIDをfirebaseで検索して変数に一時的に保存、もし見つからなければアラートを出す
        //今のコードだと1つの情報しか取れなさそう
        firestore.collection("cards").whereField(FieldPath.documentID(),  in: [ticketID])
            .getDocuments(){ (querySnapshot, err) in
            if let error = err{
                //ここをアラートにする
                print("error: \(error.localizedDescription)")
                return
            }
                //これなに
            guard let snapshot = querySnapshot else{
                return
            }
                //ここを一時的に変数に保存する指示かけばよさそう
            for document in snapshot.documents{
                
                self.titleText = document.get("cardTitle") as! String
                self.senderText = document.get("cardSender") as! String
                self.comentText = document.get("cardComent") as! String
                self.limitDateValue = document.get("cardLimit") as! Date
                self.cardSelecte = document.get("cardDesign") as! Int
                print(self.titleText)
            }
        }
        
        //一時的に保存されたチケットの内容をRealmに保存
        //Realmのクラスの型で新しい定数を宣言し、それぞれに入力した値を代入
        let newCard = RecaiveCard()
        newCard.title = titleText
        newCard.sender = senderText
        newCard.limit = limitDateValue
        newCard.coment = comentText
        newCard.design = cardSelecte
        newCard.toOther = false
                      
        //代入した値をRealmに追加
        try! realm.write{
              
            realm.add(newCard)
                  
            }
        
    }
    
    //アラートを鳴らす関数
    func getAlert(alertTitleText:String){
        
        //アラートのタイトルには引数を出力し、メッセージにはアラートが出ている原因を出力
        let alert = UIAlertController(title: alertTitleText, message: "もう一度確認してください", preferredStyle: .alert)
        
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
}
