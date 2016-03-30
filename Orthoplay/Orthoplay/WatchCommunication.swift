//
//  WatchCommunication.swift
//  Orthoplay
//
//  Created by Isak on 29/03/2016.
//  Copyright © 2016 Genau Engineering. All rights reserved.
//
/*
import Foundation
import WatchConnectivity

class WatchCommunication {
    
    var session : WCSession!
    
    func setupCommunication(){
        // To configure and activate the session
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
    }

    
    // Method to send message to watchOS
    @IBAction func sendToWatch(sender: AnyObject) {
        // A dictionary of property list values that you want to send.
        let messageToSend = ["Message":"Hi watch, are you here?"]
        
        // Task : Sends a message immediately to the counterpart and optionally delivers a response
        session.sendMessage(messageToSend, replyHandler: { (replyMessage) -> Void in
            
            // Reply handler - present the reply message on screen
            let value = replyMessage["Message"] as? String
            
            // GCD - Present on the screen
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.replyLabel.text = value!
            })
            
        }) { (error:NSError) -> Void in
            // Catch any error Handler
            print("error: \(error.localizedDescription)")
        }
    }
    
}*/