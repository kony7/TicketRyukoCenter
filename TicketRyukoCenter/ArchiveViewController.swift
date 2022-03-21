//
//  ArchiveViewController.swift
//  TicketRyukoCenter
//
//  Created by SeinaKonishi on 2022/03/21.
//

import UIKit
import RealmSwift
import Firebase

class ArchiveViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //firestoreとrealmのインスタンス化
    let firestore = Firebase.Firestore.firestore().collection("cards")
    let realm = try! Realm()
    
    //常時Realmデータを入れれるようなcardListという変数を宣言
    var cardsList: Results<RecaiveCard>!
    
    //セルの情報を入れておく定数
    let cellIdentifier = "TableViewCell"
    
    //tableviewの宣言
    @IBOutlet var table: UITableView!
    
    //デザインの変数
    var cardDesign: Int = 0
    
    // Date ⇔ Stringの相互変換をする
    let dateFormatter = DateFormatter()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //MainTableViewCellを登録してるイメージ
        table.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        
        // Realmのfunctionでデータを取得。functionを更に追加することで、フィルターもかけられる(サイトから引用)
        //たぶんRealmのデータを全部代入してる
        self.cardsList = realm.objects(RecaiveCard.self).filter("toOther == true")
        
    }
    
    //テーブルビューのセルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //もしRealm内にデータがなければ1つだけ、あればそのデータの数だけセルを用意
        if cardsList.count == 0{
            
            return 1
            
        }else{
            
        print(String(cardsList.count) + "がtableView読み込む時のカードリストの数")
        return cardsList.count
           
        }
    }
    
    //テーブルビューの内容を指定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //テーブルビューのセルをカスタムセルに設定、内容はカスタムセルの設定で行う
        let cell = table.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        
        //もしRealm内にデータがなければチケットがないことを表示
        if cardsList.count == 0{
    
            //画像も追加
            cell.titleCellText.text = "チケットが一枚もありません"
    
        }else{
            
            //もしRealm内にデータがあればタイトルを表示する
            let cardContent: RecaiveCard = self.cardsList[(indexPath as NSIndexPath).row];
            
            // フォーマット設定
            dateFormatter.dateFormat = "yyyy'年'M'月'd'日('EEEEE') 'H'時'm'分'" // 曜日1文字

            // ロケール設定（日本語・日本国固定）
            dateFormatter.locale = Locale(identifier: "ja_JP")

            // タイムゾーン設定（日本標準時固定）
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")

            // 変換
            let stringLimitDate = dateFormatter.string(from: cardContent.limit)
            
            cell.titleCellText.text = cardContent.title
            cell.senderCellText.text = cardContent.sender
            cell.comentCellText.text = cardContent.coment
            cell.limitCellText.text = stringLimitDate
            
            switch cardContent.design{
            case 1:
                cell.cardDesignView.image = UIImage(named: "TicketCardPink")
            case 2:
                cell.cardDesignView.image = UIImage(named: "TicketCardOrange")
            case 3:
                cell.cardDesignView.image = UIImage(named: "TicketCardGreen")
            case 4:
                cell.cardDesignView.image = UIImage(named: "TicketCardBlue")
            default:
                cell.cardDesignView.image = UIImage(named: "TicketCardPink")
            }
            
            
        }
        
        return cell
        
    }
    
    //テーブルビューのセルの高さの指定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
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
