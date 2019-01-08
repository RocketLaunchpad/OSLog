//
//  ViewController.swift
//  LogExample
//
//  Created by Paul Calnan on 1/5/19.
//  Copyright © 2019 Rocket Insights, Inc. All rights reserved.
//

import os.signpost
import OSLog
import UIKit

class ViewController: UITableViewController {

    @IBAction func logMsg(_ sender: Any) {
        Log.app.msg("Default button tapped")
    }

    @IBAction func logInfo(_ sender: Any) {
        Log.app.info("Info button tapped")
    }

    @IBAction func logDebug(_ sender: Any) {
        Log.app.debug("Debug button tapped")
    }

    @IBAction func logError(_ sender: Any) {
        Log.app.error("Error button tapped")
    }

    @IBAction func logFault(_ sender: Any) {
        Log.app.fault("Fault button tapped")
    }

    @IBAction func signpost1ms(_ sender: Any) {
        Log.timing.signpost(.event, name: "Tapped 1ms button")
        simulateSignpost(duration: 0.001)
    }

    @IBAction func signpost10ms(_ sender: Any) {
        Log.timing.signpost(.event, name: "Tapped 10ms button")
        simulateSignpost(duration: 0.01)
    }

    @IBAction func signpost100ms(_ sender: Any) {
        Log.timing.signpost(.event, name: "Tapped 100ms button")
        simulateSignpost(duration: 0.1)
    }

    @IBAction func signpost1000ms(_ sender: Any) {
        Log.timing.signpost(.event, name: "Tapped 1000ms button")
        simulateSignpost(duration: 1.0)
    }

    private func simulateSignpost(duration: TimeInterval) {
        Log.info("Simulating signpost with duration: \(duration) s")

        let id = Log.app.createSignpostID()

        Log.app.signpost(.begin, name: "Simulated work", signpostID: id, "Start: \(duration) s")
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            Log.app.signpost(.end, name: "Simulated work", signpostID: id, "End: \(duration) s")
        }
    }
}
