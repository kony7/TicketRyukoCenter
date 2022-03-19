//
//  ViewController.swift
//  TicketRyukoCenter
//
//  Created by SeinaKonishi on 2022/03/06.
//

import UIKit
import RealmSwift
import Firebase

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //firestoreとrealmのインスタンス化
    let firestore = Firebase.Firestore.firestore().collection("cards")
    let realm = try! Realm()
    
    //常時Realmデータを入れれるようなcardListという変数を宣言
    var cardsList: Results<RecaiveCard>!
    
    
    //tableviewの宣言
    @IBOutlet var table: UITableView!
    
    //cellに表示させるテキストの宣言
    @IBOutlet var titleCellText: UILabel!
    @IBOutlet var senderCellText: UILabel!
    @IBOutlet var limitCellText: UILabel!
    @IBOutlet var comentCellText: UILabel!
    
    //デザインの変数
    var cardDesign: Int = 0
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        table.dataSource = self
        table.delegate = self
        
        // Realmのfunctionでデータを取得。functionを更に追加することで、フィルターもかけられる(サイトから引用)
        //たぶんRealmのデータを全部代入してる
        self.cardsList = realm.objects(RecaiveCard.self)
        print(String(cardsList.count) + "がviewDidLoad終了後のカードリストの数")
        
        
    
    }
    
//    func read() -> RecaiveCard?{
//        return realm.objects(RecaiveCard.self).first
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if cardsList.count == 0{
            
            return 1
            
        }else{
        print(String(cardsList.count) + "がtableView読み込む時のカードリストの数")
        return cardsList.count
           
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if cardsList.count == 0{
            
            //ここを画像にする
            cell?.textLabel?.text = "チケットが一枚もありません"
            
        }else{
                
        let cardContent: RecaiveCard = self.cardsList[(indexPath as NSIndexPath).row];
            //ここを画像にする
            cell?.textLabel?.text = cardContent.title
            
            
        }
        return cell!
    }
    
//    func read() -> RecaiveCard?{
//        return realm.objects(RecaiveCard.self).first
//    }


}

