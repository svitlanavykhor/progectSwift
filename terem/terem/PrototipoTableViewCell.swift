//
//  PrototipoTableViewCell.swift
//  terem
//
//  Created by svitlana vykhor on 31/01/2020.
//  Copyright © 2020 svitlana vykhor. All rights reserved.
//

import UIKit

class PrototipoTableViewCell: UITableViewCell {

    @IBOutlet weak var Titulo: UILabel!
    
   
    @IBOutlet weak var fecha: UILabel!
    
    @IBOutlet weak var magnitud: UILabel!
   
    
    @IBOutlet weak var imagen: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
         self.magnitud.layer.cornerRadius = 15//redondear el label
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
