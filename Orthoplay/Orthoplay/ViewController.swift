//
//  ViewController.swift
//  Orthoplay
//
//  Created by Isak on 28/03/2016.
//  Copyright © 2016 Genau Engineering. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    public @IBOutlet weak var volumeDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeVolume(sender: AnyObject) {
        var t:float_t
        t = sender.value
        self.volumeDisplay.text = String(format: "%.0f", t)
    }

}

