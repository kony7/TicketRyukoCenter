//
//  ViewController.swift
//  TicketRyukoCenter
//
//  Created by SeinaKonishi on 2022/03/06.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var table: UITableView!
    
    var titleArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        table.dataSource = self
        table.delegate = self
    
       // titleArray = []
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if titleArray.count == 0{
            return 1
        }else{
        return titleArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if titleArray.count == 0{
            
            //ここを画像にする
            cell?.textLabel?.text = "チケットが一枚もありません"
            
        }else{
            
            //ここを画像にする
        cell?.textLabel?.text = titleArray[indexPath.row]
            
        }
        return cell!
    }


}

