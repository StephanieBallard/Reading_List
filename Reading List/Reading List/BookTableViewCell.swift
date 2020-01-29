//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Stephanie Ballard on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book?

    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var readButton: UIButton!
    
    @IBAction func readButtonTapped(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //left off on step 3 on wire things up*****
    func undateViews() {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
