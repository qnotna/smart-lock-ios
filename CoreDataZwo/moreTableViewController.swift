//
//  moreTableViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 04.09.16.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

class moreTableViewController: UITableViewController {
    
    @IBOutlet weak var deleteCell: UITableViewCell!
    @IBOutlet weak var imageView: UIImageView!
    
    func startAnimation() {
        var bilderNamen = ["animation 1","animation 2","animation 3","animation 4","animation 5","animation 6","animation 7","animation 8","animation 9","animation 10","animation 11"]
        
        var bilder = [UIImage]()
        for i in 0..<bilderNamen.count {
            bilder.append(UIImage(named: bilderNamen[i])!)
        }
        imageView.animationImages = bilder
        imageView.animationDuration = 5
        imageView.startAnimating()
    }
    
    @IBOutlet weak var vibrationSwitch: UISwitch!

    @IBAction func toggleVibrationSwitch(_ sender: UISwitch) {
        if vibrationSwitch.isOn {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        } else {
            print("Vibration deaktiviert")
        }
    }
  
    
  /*   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 3 {
            view.backgroundColor = UIColor(white: 0, alpha: 0.25)
            performSegue(withIdentifier: "segueToRingtoneContainerViewController", sender: Any.self)

        } else {}
    }
  */
    @IBOutlet weak var deletingActivityIndicator: UIActivityIndicatorView!
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 2 && indexPath.row == 0 {
            let alertController = UIAlertController(title: nil, message: "Das auf dem Schloss angelegte Datenprofil wirklich unwiederruflich entfernen?", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel) { (action) in
                print("Abbrechen")
            }
            alertController.addAction(cancelAction)
            let destroyAction = UIAlertAction(title: "Entfernen", style: .destructive) { (action) in
                print("Löschen")
                self.deletingActivityIndicator.isHidden = false
                self.deletingActivityIndicator.startAnimating()
                self.stopActivityIndicator()
                self.deleteCell.accessoryType = .none
            }
            alertController.addAction(destroyAction)
            self.present(alertController, animated: true) {
            }
            print("didSelectDelete")
        } else {}
      

    }
    
      func stopActivityIndicator() {
        if #available(iOS 10.0, *) {
            let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { (timer) in
                self.deletingActivityIndicator.isHidden = true
                self.deletingActivityIndicator.stopAnimating()
                self.deleteCell.accessoryType = .checkmark

            }
        } else { }
            // Earlier versions
        }
    
    override func viewDidLoad() {
        self.deletingActivityIndicator.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        startAnimation()
        super.viewDidLoad()
    }
    
    func viewDidAppear() {
        self.deleteCell.accessoryType = .none
    //    super.viewDidAppear()
    }
}
