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
    
    let firestore = Firebase.Firestore.firestore().collection("cards")
    
    let realm = try! Realm()

    @IBOutlet var table: UITableView!
    
    @IBOutlet var titleCellText: UILabel!
    @IBOutlet var senderCellText: UILabel!
    @IBOutlet var limitCellText: UILabel!
    @IBOutlet var comentCellText: UILabel!
    
    var cardDesign: Int = 0
    
    var cardsList: Results<RecaiveCard>!
    
    var titleArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
 
        let cardSave: RecaiveCard? = read()
        
        if let cardSave = cardSave {
            titleArray.append(cardSave.title)
        }
        
        
        table.dataSource = self
        table.delegate = self
        
       // let recaiveCard: RecaiveCard? = read()
        

        
        self.cardsList = realm.objects(RecaiveCard.self)
    
       // titleArray = []
    }
    
    func read() -> RecaiveCard?{
        return realm.objects(RecaiveCard.self).first
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if cardsList.count == 0{
            
            return 1
            
        }else{
            
        return cardsList.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if titleArray.count == 0{
            
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

