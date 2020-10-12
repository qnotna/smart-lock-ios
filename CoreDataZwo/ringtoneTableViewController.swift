//
//  ringtoneTableViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 26/09/2016.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ringtoneTableViewController : UITableViewController {
    
    @IBOutlet weak var sound1Cell: UITableViewCell!
    @IBOutlet weak var sound2cell: UITableViewCell!
    @IBOutlet weak var sound3Cell: UITableViewCell!
    @IBOutlet weak var noSoundCell: UITableViewCell!
    
    //var sound1 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sound1", ofType: "mp3")!)
    //var sound2 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sound2", ofType: "mp3")!)
    //var sound3 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sound3", ofType: "mp3")!)

    @IBAction func fertigButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func playSound1() {
        do {
            let sound1 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "sound1", ofType: "mp3")!))
            sound1.prepareToPlay()
            sound1.play()
            print("Sound1")
        } catch {
            print("error")
        }
    }
    func playSound2() {
        do {
            let sound2 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "sound2", ofType: "mp3")!))
            sound2.prepareToPlay()
            sound2.play()
            print("Sound2")
        } catch {
            print("error")
        }
    }
    func playSound3() {
        do {
            let sound3 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "sound3", ofType: "mp3")!))
            sound3.prepareToPlay()
            sound3.play()
            print("Sound3")
        } catch {
            print("error")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                sound1Cell.accessoryType = .checkmark
                sound2cell.accessoryType = .none
                sound3Cell.accessoryType = .none
                noSoundCell.accessoryType = .none
                self.playSound1()
            }
        }
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                sound1Cell.accessoryType = .none
                sound2cell.accessoryType = .checkmark
                sound3Cell.accessoryType = .none
                noSoundCell.accessoryType = .none
                self.playSound2()
            }
        }
        if indexPath.section == 0 {
            if indexPath.row == 2 {
                sound1Cell.accessoryType = .none
                sound2cell.accessoryType = .none
                sound3Cell.accessoryType = .checkmark
                noSoundCell.accessoryType = .none
                self.playSound3()
            }
        }
        if indexPath.section == 0 {
            if indexPath.row == 3 {
                sound1Cell.accessoryType = .none
                sound2cell.accessoryType = .none
                sound3Cell.accessoryType = .none
                noSoundCell.accessoryType = .checkmark
                print("Kein Sound")
            }
        }
    }
}
