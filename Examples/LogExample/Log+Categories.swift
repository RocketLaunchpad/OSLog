//
//  Log+Categories.swift
//  LogExample
//
//  Created by Paul Calnan on 1/7/19.
//  Copyright © 2019 Rocket Insights, Inc. All rights reserved.
//

import Foundation
import OSLog

extension Log {
    private static let subsystem = "com.rocketinsights.LogExample"

    static let app = Log(subsystem: subsystem, category: "app", isEnabled: true)
    static let timing = Log(subsystem: subsystem, category: "timing", isEnabled: true)
}
