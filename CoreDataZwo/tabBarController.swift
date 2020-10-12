//
//  tabBarController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 29/09/2016.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit

class TabBarController : UITabBarController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        performSegue(withIdentifier: "segueForConnectingWithDevice", sender: self)
        print("tabBarDidAppear")
        self.definesPresentationContext = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueForConnectingWithDevice" {
            if let modalViewController1 = segue.destination as? verbindenTableViewController {
                modalViewController1.delegate = self
            }
        }
        
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension TabBarController: ModalViewControllerDelegate {
    func dismissed() {
        print("delegate did work")
        dismiss(animated: true, completion: nil)
        
        let connectionState = false
        
        if connectionState == true {
            self.performSegue(withIdentifier: "segueToAnsichtViewControllerAfterConnection", sender: self)
            //self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.dismiss(animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: "egueToHinzufügenViewControllerAfterConnection", sender: self)
        }

    }
}
