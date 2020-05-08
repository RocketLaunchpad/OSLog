//
//  ViewController.swift
//  LogExample
//
//  Copyright (c) 2019-2020 Rocket Insights, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
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
