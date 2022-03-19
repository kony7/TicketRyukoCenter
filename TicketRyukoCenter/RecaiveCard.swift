//
//  RecaiveCard.swift
//  TicketRyukoCenter
//
//  Created by SeinaKonishi on 2022/03/08.
//

import Foundation
import RealmSwift

//Realmに保存する時のクラス
class RecaiveCard: Object{
    
    @objc dynamic var title: String = ""
    @objc dynamic var sender: String = ""
    @objc dynamic var limit: Date = Date()
    @objc dynamic var coment: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var design: Int = 0
    
}

