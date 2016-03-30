//
//  InterfaceController.swift
//  Orthowatch Extension
//
//  Created by Isak on 28/03/2016.
//  Copyright © 2016 Genau Engineering. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var volumeDisplay: WKInterfaceLabel!
    var session : WCSession!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // To configure and activate the session
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // WCSession Delegate protocol
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        
        // Reply handler, received message
        let value = message["Message"] as? String
        
        // GCD - Present on the screen
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.volumeDisplay.setText(value)
        }
        
        // Send a reply
        //replyHandler(["Message":"Yes!\niOS 9.0 + WatchOS2 ..AAAAAAmazing!"])
        
    }

}
