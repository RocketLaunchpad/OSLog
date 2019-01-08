//
//  LogFormatter.swift
//  OSLog
//
//  Created by Paul Calnan on 1/5/19.
//  Copyright © 2019 Rocket Insights, Inc. All rights reserved.
//

import Foundation
import os

/// Used to format log messages.
/// See Log.formatter.
public protocol LogFormatter {
    /**
     Given a message and contextual information, returns a string representation to be sent to the log.

     - Parameters:
         - type: the log level
         - message: the object to be logged
         - file: the full path of the source file that contains the logging call
         - function: the name of the function that contains the logging call
         - line: the line number of the logging call
     - Returns: A string representation of the message and any desired contextual information.
     */
    func format(type: OSLogType, message: String, file: StaticString, function: StaticString, line: UInt) -> String
}

/**
 The default log formatter. Formats as `[\(type)] (\(filename):\(line)) \(message)`
 */
public class DefaultLogFormatter: LogFormatter {

    /// Creates a new default log formatter.
    public init() { }

    /// - See: `LogFormatter.format(type:message:file:function:line:)`
    public func format(type: OSLogType, message: String, file: StaticString, function: StaticString, line: UInt) -> String {
        let filename = (file.description as NSString).lastPathComponent
        return "[\(type)] (\(filename):\(line)) \(message)"
    }
}

extension OSLogType: CustomStringConvertible {
    /// A string representation of the name of this object.
    public var description: String {
        switch self {

        case .info:
            return "info"

        case .debug:
            return "debug"

        case .error:
            return "error"

        case .fault:
            return "fault"

        case .default:
            return "msg"

        default:
            return "???"
        }
    }
}
