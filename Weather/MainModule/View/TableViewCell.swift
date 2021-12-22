//
//  TableViewCell2.swift
//  Weather
//
//  Created by Tanya on 09.12.2021.
//

import Foundation
import UIKit


protocol CellProtocol {
    var selectedСities: [City] {get set}
}

class TableViewCell: UITableViewCell, CellProtocol {
    
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var buttonInCell: UIButton!
    var selectedСities: [City] = []
    var conditionButton = false
    var callback: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
   @IBAction func likeButtonPressed(_ sender: UIButton) {
        callback?()
        conditionButton = !conditionButton
        updateButtonState()
    }
    
    func callback(indexPath: IndexPath) {}
    func updateButtonState() {
        if conditionButton {
            buttonInCell.setImage(UIImage(named: "on"), for: .normal)
        //  добавить удаление из избранного
        }
        else {
            buttonInCell.setImage(UIImage(named: "true"), for: .normal)
        }
    }

    
    


    }
    

