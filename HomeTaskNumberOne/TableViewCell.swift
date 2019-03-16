//
//  TableViewCell.swift
//  
//
//  Created by Максим Егоров on 15/03/2019.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var currentTempCLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
