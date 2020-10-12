//
//  startseiteTableViewCellViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 26.01.17.
//  Copyright © 2017 Anton Quietzsch. All rights reserved.
//

import UIKit

class startseiteTableViewCellViewController: UITableViewCell {

    @IBOutlet weak var colorView: UILabel!
    
    func viewDidLoad() {
        print("tableViewCellDidLoad")
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = 12.5
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
