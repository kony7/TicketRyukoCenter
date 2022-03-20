//
//  TableViewCell.swift
//  TicketRyukoCenter
//
//  Created by SeinaKonishi on 2022/03/20.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //cellに表示させるテキストの宣言
    @IBOutlet var titleCellText: UILabel!
    @IBOutlet var senderCellText: UILabel!
    @IBOutlet var limitCellText: UILabel!
    @IBOutlet var comentCellText: UILabel!
    @IBOutlet var cardDesignView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
