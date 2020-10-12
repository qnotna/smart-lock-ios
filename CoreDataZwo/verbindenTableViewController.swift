//
//  verbindenTableViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 29/09/2016.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit

class verbindenTableViewController : UITableViewController {
    
    @IBOutlet weak var connectionActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var statusCell: UITableViewCell!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var colorView: UILabel!
    
    let connectionState = false
    let deviceIsUnknown = false
    
    func connectionStateDidChange() {
       if connectionState == true {
            self.connectionActivityIndicator.isHidden = true
            self.colorView.isHidden = false
            actionButton.setTitle("Anzeigen", for: .normal)
        } else {
            actionButton.setTitle("Speichern", for: .normal)
            actionButton.isEnabled = false
            self.connectionActivityIndicator.isHidden = false
            connectionActivityIndicator.startAnimating()
            if #available(iOS 10.0, *) {
                let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
                    self.connectionActivityIndicator.isHidden = true	
                    self.actionButton.isEnabled = true
                    self.connectionActivityIndicator.stopAnimating()
                }
            } else { }
            self.colorView.isHidden = true
        }
    }
    
    @IBAction func dismissModalViewController(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            tableView.separatorColor = UIColor.clear
        }
        else {
        tableView.separatorColor = UIColor.gray
        }
        return statusCell
    }

    override func viewDidAppear(_ animated: Bool) {
        self.connectionStateDidChange()
        super.viewDidAppear(true)
       // statusCell.separatorColor = UIColor.clear
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = 12.5
        
    }
    
    var delegate: ModalViewControllerDelegate?
    
    @IBAction func actionToConnectButton(_ sender: UIButton) {
        
        delegate?.dismissed()
        
        if connectionState == true {
            self.performSegue(withIdentifier: "segueToAnsichtViewControllerAfterConnection", sender: self)
            //self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.dismiss(animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: "segueToHinzufügenViewControllerAfterConnection", sender: self)
        }
        
    }

}

protocol ModalViewControllerDelegate: class {
    func dismissed()
}
