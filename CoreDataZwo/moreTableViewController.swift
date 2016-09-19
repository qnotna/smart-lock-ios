//
//  moreTableViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 04.09.16.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit

class moreTableViewController: UITableViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func startAnimation(_ sender: UIBarButtonItem) {
        var bilderNamen = ["animation 1","animation 2","animation 3","animation 4","animation 5","animation 6","animation 7","animation 8","animation 9","animation 10","animation 11"]
        
        var bilder = [UIImage]()
        for i in 0..<bilderNamen.count {
            bilder.append(UIImage(named: bilderNamen[i])!)
        }
        imageView.animationImages = bilder
        imageView.animationDuration = 0.5
        imageView.startAnimating()
    }

    
    override func viewDidLoad() {        
        let nib = UINib(nibName: "animationTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "animationCell")
        super.viewDidLoad()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
