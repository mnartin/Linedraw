//
//  ViewController.swift
//  Orthoplay
//
//  Created by Isak on 28/03/2016.
//  Copyright © 2016 Genau Engineering. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {

    @IBOutlet weak var volumeDisplay: UILabel!
    var session : WCSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeVolume(sender: AnyObject) {
        var volume:float_t
        volume = sender.value
        let volumeString = String(format: "%.0f", volume)
        
        //Set volume display
        self.volumeDisplay.text = volumeString
        
        //Send to watch
        sendToWatch(volumeString)
        
    }
    
    // Method to send message to watchOS
    func sendToWatch(message: String) {
        // A dictionary of property list values that you want to send.
        let messageToSend = ["Message":message]
        
        // Task : Sends a message immediately to the counterpart and optionally delivers a response
        session.sendMessage(messageToSend, replyHandler: { (replyMessage) -> Void in
            
            // Reply handler - present the reply message on screen
            let value = replyMessage["Message"] as? String
            
            // GCD - Present on the screen
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //self.replyLabel.text = value!
            })
            
        }) { (error:NSError) -> Void in
            // Catch any error Handler
            print("error: \(error.localizedDescription)")
        }
    }
    
    // WCSession Delegate protocol
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        // Reply handler, received message
        let value = message["Message"] as? String
        
        // GCD - Present on the screen
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            //self.messageLabel.setText(value!)
            self.volumeDisplay.text = value
        }
        
        // Send a reply
        //replyHandler(["Message":"Yes!\niOS 9.0 + WatchOS2 ..AAAAAAmazing!"])
        
    }

}

