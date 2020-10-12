//
//  verbindenContainerViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 29/09/2016.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit

class verbindenContainerViewController : UIViewController {
 
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = UIColor.clear
        view.backgroundColor = UIColor(white: 0, alpha: 0.25)
        containerView.layer.cornerRadius = 15
        containerView.layer.masksToBounds = true
        super.viewDidLoad()
    }
}
