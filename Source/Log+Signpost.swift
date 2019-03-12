//
//  Log+Signpost.swift
//  OSLog
//
//  Copyright (c) 2019 Rocket Insights, Inc.
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

import Foundation
import os.signpost

extension Log {

    /**
     Creates a signpost ID that is unique among signposts logging to this log object.

     - Returns: a signpost ID that is unique among signposts logging to this log object
     - Requires: iOS 12 or later.
     */
    @available(iOS 12.0, *)
    public func createSignpostID() -> OSSignpostID {
        return OSSignpostID(log: osLog)
    }

    /**
     Marks a point of interest in your code as a time interval or as an event for debugging performance in Instruments.

     - Parameters:
         - type: indicates the role of this signpost
         - name: the name of this signpost
     - Requires: iOS 12 or later.
     */
    @available(iOS 12.0, *)
    public func signpost(_ type: OSSignpostType, name: StaticString) {
        os_signpost(type, log: osLog, name: name)
    }

    /**
     Marks a point of interest in your code as a time interval or as an event for debugging performance in Instruments.

     - Parameters:
         - type: indicates the role of this signpost
         - name: the name of this signpost
         - message: a message to associate with this signpost
     - Requires: iOS 12 or later.
     */
    @available(iOS 12.0, *)
    public func signpost(_ type: OSSignpostType, name: StaticString, _ message: String) {
        os_signpost(type, log: osLog, name: name, "%{public}s", message)
    }

    /**
     Marks a point of interest in your code as a time interval or as an event for debugging performance in Instruments.

     - Parameters:
         - type: indicates the role of this signpost
         - name: the name of this signpost
         - signpostID: an identifier for this signpost
     - Requires: iOS 12 or later.
     */
    @available(iOS 12.0, *)
    public func signpost(_ type: OSSignpostType, name: StaticString, signpostID: OSSignpostID) {
        os_signpost(type, log: osLog, name: name, signpostID: signpostID)
    }

    /**
     Marks a point of interest in your code as a time interval or as an event for debugging performance in Instruments.

     - Parameters:
        - type: indicates the role of this signpost
        - name: the name of this signpost
        - signpostID: an identifier for this signpost
        - message: a message to associate with this signpost
     - Requires: iOS 12 or later.
     */
    @available(iOS 12.0, *)
    public func signpost(_ type: OSSignpostType, name: StaticString, signpostID: OSSignpostID, _ message: String) {
        os_signpost(type, log: osLog, name: name, signpostID: signpostID, "%{public}s", message)
    }
}
