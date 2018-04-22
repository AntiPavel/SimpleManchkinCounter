//
//  Logging.swift
//  SimpleManchkinCounter
//
//  Created by Antonov, Pavel on 4/22/18.
//  Copyright © 2018 paul. All rights reserved.
//

import Foundation

/**
 * Log levels helping to limit the output in Console.
 */
enum LogLevel: Int {
    case verbose    = 0 //to be used exclusively for short-term debugging (e.g. printing raw responses from backend, components lifecycle etc.)
    case info       = 1
    case warning    = 2
    case critical   = 3
}

/**
 * Define the minimum log level appropriate for debug purposes.
 *
 *  Log records having log level greater or equal to 'minLogLevel' will show up in the console
 *  only if the DEBUG custom compiler flag is set for a build configuration.
 *
 *  The DEBUG flag is added *by default* for the Debug configuration on the *project-level*
 *  and is therefore *inherited* in all targets.
 */
fileprivate let minLogLevel = LogLevel.verbose.rawValue

/**
 * Write a new log record to the console.
 *
 * - Parameters:
 *   - tag: some descriptive name of the source scope
 *   - message: log message
 *   - error: error representation to provide more details on a failure
 *   - logLevel: indicate the importance of the log call, defaults to "Info"
 *   - sourceMethod: calling method name
 *   - sourceLine: line number within the source scope
 */
func logD(_ tag: String, message: String, error: Error? = nil, logLevel: LogLevel = .info, sourceMethod: String = #function, sourceLine: UInt = #line) {
    #if DEBUG
        
        guard logLevel.rawValue >= minLogLevel else {
            return
        }
        
        let logPrefix = getLogPrefix(logLevel)
        var logOutput = "\(logPrefix)/\(tag)"
        if (logLevel == .verbose) {
            logOutput += ":\(sourceMethod):" + String(sourceLine)
        }
        
        logOutput += ": " + message
        
        if let err = error {
            logOutput += "\n" + err.localizedDescription
        }
        
        NSLog("%@", logOutput)
    #endif
}

fileprivate func getLogPrefix(_ logLevel: LogLevel) -> String {
    var logPrefix = ""
    
    switch logLevel {
    case .verbose:
        logPrefix = "D"
    case .info:
        logPrefix = "I"
    case .warning:
        logPrefix = "⚠️"
    case .critical:
        logPrefix = "❗️"
    }
    
    return logPrefix
}
