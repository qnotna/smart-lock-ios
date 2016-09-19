//
//  farbeTableViewController.swift
//  CoreDataZwo
//
//  Created by Anton Quietzsch on 04.09.16.
//  Copyright © 2016 Anton Quietzsch. All rights reserved.
//

import UIKit

class farbeTableViewController : UITableViewController {
    
    @IBOutlet weak var rotSlider: UISlider!
    
    @IBOutlet weak var grünSlider: UISlider!
    
    @IBOutlet weak var blauSlider: UISlider!
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBAction func rotSliderAction(_ sender: UISlider) {
        changeColors()
    }
    
    @IBAction func grünSliderAction(_ sender: UISlider) {
        changeColors()
    }
    
    @IBAction func blauSliderAction(_ sender: UISlider) {
        changeColors()
    }

    var rot: Float = 0
    var grün: Float = 0
    var blau: Float = 0
    
    func displayLabelDidChangeColor() {
        displayLabel.backgroundColor = UIColor(red: CGFloat(rot), green: CGFloat(grün), blue: CGFloat(blau), alpha: 1.0)
    }
    
    func changeColors() {
        rot = rotSlider.value
        grün = grünSlider.value
        blau = blauSlider.value
        displayLabelDidChangeColor()
        print("\(displayLabel.backgroundColor)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
