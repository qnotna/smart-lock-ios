//
//  morePopUpViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 19.09.16.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit

class morePopUpTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // self.view.removeFromSuperview()
        self.navigationController?.isNavigationBarHidden = true;
        view.backgroundColor = UIColor(white: 1, alpha: 0.0)

    }
    
    func didRecieveMemoryWarning() {
 //       super.didRecieveMemoryWarning
    }
    
}
