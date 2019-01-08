//
//  Log+Signpost.swift
//  OSLog
//
//  Created by Paul Calnan on 1/5/19.
//  Copyright © 2019 Rocket Insights, Inc. All rights reserved.
//

import Foundation
import os.signpost

extension Log {

    @available(iOS 12.0, *)
    public func createSignpostID() -> OSSignpostID {
        return OSSignpostID(log: osLog)
    }

    @available(iOS 12.0, *)
    public func signpost(_ type: OSSignpostType, name: StaticString) {
        os_signpost(type, log: osLog, name: name)
    }

    @available(iOS 12.0, *)
    public func signpost(_ type: OSSignpostType, name: StaticString, _ message: String) {
        os_signpost(type, log: osLog, name: name, "%{public}s", message)
    }

    @available(iOS 12.0, *)
    public func signpost(_ type: OSSignpostType, name: StaticString, signpostID: OSSignpostID) {
        os_signpost(type, log: osLog, name: name, signpostID: signpostID)
    }

    @available(iOS 12.0, *)
    public func signpost(_ type: OSSignpostType, name: StaticString, signpostID: OSSignpostID, _ message: String) {
        os_signpost(type, log: osLog, name: name, signpostID: signpostID, "%{public}s", message)
    }
}
