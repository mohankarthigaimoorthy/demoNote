//
//  NoteCell.swift
//  demoNotes
//
//  Created by Mohan K on 14/04/23.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var Content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
