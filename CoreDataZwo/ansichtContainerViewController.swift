//
//  ansichtContainerViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 27/09/2016.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit

class ansichtContainerViewController : UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var selectedIndex = 0
    
    override func viewDidLoad() {
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = UIColor.clear
        view.backgroundColor = UIColor(white: 0, alpha: 0.25)
        containerView.layer.cornerRadius = 15
        containerView.layer.masksToBounds = true
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ansichtEmbed" {
            if let ansichtController = segue.destination as? ansichtTableViewController {
                ansichtController.selectedIndex = selectedIndex
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        performSegue(withIdentifier: "segueToConfirmPasswordContainerViewController", sender: self)
    }
}
