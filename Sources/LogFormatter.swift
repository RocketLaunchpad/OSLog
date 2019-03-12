//
//  LogFormatter.swift
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
