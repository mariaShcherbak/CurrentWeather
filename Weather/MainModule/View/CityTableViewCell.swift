//
//  File.swift
//  Weather
//
//  Created by Tanya on 08.12.2021.
//

import Foundation
protocol CellProtocol {
    var selectedСities: [City] {get set}
}

class CityTableViewCell: UITableViewCell, CellProtocol {
    var selectedСities: [City] = []
    var conditionButton = false
    
    
    static let idCell = "сityCell"
    
    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var buttonInCell: UIButton!
    var callback: (()->Void)?
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(true, animated: true)
        
    }
    func callback(indexPath: IndexPath) {}
    
   @IBAction func likeButtonPressed(_ sender: UIButton) {
        callback?()
        conditionButton = !conditionButton
        updateButtonState()
    }
    
  
    func updateButtonState() {
        if conditionButton {
            buttonInCell.setImage(UIImage(named: "on"), for: .normal)
        //  добавить удаление из избранного
        }
        else {
            buttonInCell.setImage(UIImage(named: "true"), for: .normal)
            
            //print(selectedСities)
        }
    }
}
