//
//  Log.swift
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
import os

/**
 Provides an interface into Apple's Unified Logging facility. Instances of this type correspond to custom `OSLog` objects, identified by an identifier string (in reverse DNS notation, like `com.rocketinsights.subsystem_name`) and a category for the logging subsystem. Both of these are used to categorize and filter related log messages and group related logging settings.

 There is also a static interface on this type which logs to the shared `Log.default` object.

 This provides a thin wrapper around the `OSLog` type and the `os_log` function.

 Generally, use the static interface to perform logging using the system’s behavior. Create a custom log object only when you want to tag messages with a specific subsystem and category for the purpose of filtering, or to customize the logging behavior of your subsystem with a profile for debugging purposes.

 ### Important

 Log message lines greater than the system’s maximum message length are truncated when stored by the logging system. Complete messages are visible when using the `log` command-line tool to view a live stream of activity. Bear in mind, however, that streaming log data is an expensive activity.
 */
public class Log {

    /// The default log object, referencing `OSLog.default`.
    public static let `default` = Log(OSLog.default, formatter: DefaultLogFormatter(), isEnabled: true)

    /// The underlying `OSLog` object.
    public let osLog: OSLog

    /// The log formatter.
    private let formatter: LogFormatter

    /// Whether this log is enabled.
    public var isEnabled: Bool

    /**
     Creates a custom log object for sending messages to the logging system.

     - Parameters:
         - subsystem: An identifier string, in reverse DNS notation, representing the subsystem that’s performing logging. For example, `com.rocketinsights.subsystem_name`. The subsystem is used for categorization and filtering of related log messages, as well as for grouping related logging settings.
         - category: A category within the specified subsystem. The category is used for categorization and filtering of related log messages, as well as for grouping related logging settings within the subsystem’s settings. A category’s logging settings override those of the parent subsystem.
         - formatter: The log formatter, defaulting to a `DefaultLogFormatter`.
     */
    public convenience init(subsystem: String, category: String, formatter: LogFormatter = DefaultLogFormatter(), isEnabled: Bool) {
        self.init(OSLog(subsystem: subsystem, category: category), formatter: formatter, isEnabled: isEnabled)
    }

    /// Internal initializer
    private init(_ osLog: OSLog, formatter: LogFormatter, isEnabled: Bool) {
        self.osLog = osLog
        self.formatter = formatter
        self.isEnabled = isEnabled
    }

    /// Internal log function to format the message and pass it to `os_log`.
    private func log(_ type: OSLogType, _ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        guard isEnabled else {
            return
        }

        let formatted = formatter.format(type: type, message: message(), file: file, function: function, line: line)
        os_log("%{public}@", log: osLog, type: type, formatted)
    }
}

// MARK: - Instance methods

extension Log {

    /**
     Sends a default-level message using this custom log object.

     Default-level messages are initially stored in memory buffers. Without a configuration change, they are compressed and moved to the data store as memory buffers fill. They remain there until a storage quota is exceeded, at which point, the oldest messages are purged. Use this level to capture information about things that might result a failure.

     - Parameters:
         - message: The message to log.
         - file: The current filename (default `#file`). Generally, the default value should be used.
         - function: The current function name (default `#function`). Generally, the default value should be used.
         - line: The current line number (default `#line`). Generally, the default value should be used.
     */
    public func msg(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(.default, message, file: file, function: function, line: line)
    }

    /**
     Sends an info-level message using this custom log object.

     Info-level messages are initially stored in memory buffers. Without a configuration change, they are not moved to the data store and are purged as memory buffers fill. They are, however, captured in the data store when faults and, optionally, errors occur. When info-level messages are added to the data store, they remain there until a storage quota is exceeded, at which point, the oldest messages are purged. Use this level to capture information that may be helpful, but isn’t essential, for troubleshooting errors.

     - Parameters:
         - message: The message to log.
         - file: The current filename (default `#file`). Generally, the default value should be used.
         - function: The current function name (default `#function`). Generally, the default value should be used.
         - line: The current line number (default `#line`). Generally, the default value should be used.
     */
    public func info(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(.info, message, file: file, function: function, line: line)
    }

    /**
     Sends a debug-level message using this custom log object.

     Debug-level messages are only captured in memory when debug logging is enabled through a configuration change. They’re purged in accordance with the configuration’s persistence setting. Messages logged at this level contain information that may be useful during development or while troubleshooting a specific problem. Debug logging is intended for use in a development environment and not in shipping software.

     - Parameters:
         - message: The message to log.
         - file: The current filename (default `#file`). Generally, the default value should be used.
         - function: The current function name (default `#function`). Generally, the default value should be used.
         - line: The current line number (default `#line`). Generally, the default value should be used.
     */
    public func debug(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(.debug, message, file: file, function: function, line: line)
    }

    /**
     Sends an error-level message using this custom log object.

     Error-level messages are always saved in the data store. They remain there until a storage quota is exceeded, at which point, the oldest messages are purged. Error-level messages are intended for reporting process-level errors. If an activity object exists, logging at this level captures information for the entire process chain.

     - Parameters:
         - message: The message to log.
         - file: The current filename (default `#file`). Generally, the default value should be used.
         - function: The current function name (default `#function`). Generally, the default value should be used.
         - line: The current line number (default `#line`). Generally, the default value should be used.
     */
    public func error(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(.error, message, file: file, function: function, line: line)
    }

    /**
     Sends a fault-level message using this custom log object.

     Fault-level messages are always saved in the data store. They remain there until a storage quota is exceeded, at which point, the oldest messages are purged. Fault-level messages are intended for capturing system-level or multi-process errors only. If an activity object exists, logging at this level captures information for the entire process chain.

     - Parameters:
         - message: The message to log.
         - file: The current filename (default `#file`). Generally, the default value should be used.
         - function: The current function name (default `#function`). Generally, the default value should be used.
         - line: The current line number (default `#line`). Generally, the default value should be used.
     */
    public func fault(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        log(.fault, message, file: file, function: function, line: line)
    }
}

// MARK: - Static methods

extension Log {

    /// Sends a default-level message to the default log object.
    /// - SeeAlso: `Log.msg(_:file:function:line:)`
    public static func msg(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Log.default.msg(message, file: file, function: function, line: line)
    }

    /// Sends an info-level message to the default log object.
    /// - SeeAlso: `Log.info(_:file:function:line:)`
    public static func info(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Log.default.info(message, file: file, function: function, line: line)
    }

    /// Sends a debug-level message to the default log object.
    /// - SeeAlso: `Log.debug(_:file:function:line)`
    public static func debug(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Log.default.debug(message, file: file, function: function, line: line)
    }

    /// Sends an error-level message to the default log object.
    /// - SeeAlso: `Log.error(_:file:function:line)`
    public static func error(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Log.default.error(message, file: file, function: function, line: line)
    }

    /// Sends a fault-level message to the default log object.
    /// - SeeAlso: `Log.fault(_:file:function:line)`
    public static func fault(_ message: @autoclosure () -> String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        Log.default.fault(message, file: file, function: function, line: line)
    }
}
