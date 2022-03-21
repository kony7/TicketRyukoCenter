//
//  SendViewController.swift
//  TicketRyukoCenter
//
//  Created by SeinaKonishi on 2022/03/07.
//

import UIKit
import Firebase

class SendViewController: UIViewController, UITextFieldDelegate {
    
    //firestoreのインスタンス化
    let firestore = Firebase.Firestore.firestore().collection("cards")
    
    //カード内容を表示させるラベルとイメージビューの宣言
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var senderLabel:UILabel!
    @IBOutlet var comentLabel:UILabel!
    @IBOutlet var limitdayLabel:UILabel!
    @IBOutlet var cardImageView:UIImageView!
    
    //発券番号を表示させるテキストフィールドの宣言
    @IBOutlet var idTextField:UITextField!
    
    //共有のモーダルが出る贈るボタンの宣言
    @IBOutlet var sendButton:UIButton!
    
    //前の画面から渡されてきた値を受け取る変数
    var titleText:String = ""
    var senderText:String = ""
    var comentText:String = ""
    var design:Int = 0
    var cardID:String = ""
    var limitDate:Date = Date()
    
    // Date ⇔ Stringの相互変換をする
    let dateFormatter = DateFormatter()

    
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        idTextField.delegate = self
        idTextField.text = cardID
        
        //前の画面から渡されてきたカードデザイン変数によって表示させる画像を変える
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
        
        //前の画面から渡されてきた値をラベルに表示させる
        titleLabel.text = titleText
        senderLabel.text = senderText
        comentLabel.text = comentText
        
        
        // フォーマット設定
        dateFormatter.dateFormat = "yyyy'年'M'月'd'日('EEEEE') 'H'時'm'分'" // 曜日1文字
        //dateFormatter.dateFormat = "M'月'd'日 ('EEEE')'" // 曜日3文字

        // ロケール設定（日本語・日本国固定）
        dateFormatter.locale = Locale(identifier: "ja_JP")

        // タイムゾーン設定（日本標準時固定）
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")

        // 変換
        let stringLimitDate = dateFormatter.string(from: limitDate)
        
        limitdayLabel.text = stringLimitDate
        
        
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
