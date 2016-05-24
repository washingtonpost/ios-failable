//
//  Failable.swift
//  Pods
//
//  Created by Davis, William on 5/23/16.
//
//

import Foundation
import ObjectMapper

/**
 Failable is an object returned in mappable completions, using the Either monad,
 the response is either successful or an error was encountered.

 - Success: The response and mapping was successful, resulting in Mappable data.
 - Failure: An error was encountered. The error that caused the failure.
 */
public enum Failable<T where T:Mappable> {
    case Success(T)
    case Failure(NSError)

    /// Returns true if the Failible operation succeeded, or False if it failed.
    public var successful: Bool {
        switch self {
        case .Success:
            return true
        case .Failure:
            return false
        }
    }

    /// Retrieves the value, if any, from the Failible instance. If the operation failed, returns nil.
    public var value: T? {
        switch self {
            case .Success(let x):
                return x
            case .Failure:
                return nil
        }
    }

    /// Retrieves the error, if any, from the Failible instance. If the opration succeeded, returns nil.
    public var error: NSError? {
        switch self {
        case .Success:
            return nil
        case .Failure(let error):
            return error
        }
    }
}

// MARK: - CustomStringConvertible

extension Failable: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Success(let x):
            return "Success: \(x)"
        case .Failure(let error):
            return "Failure: \(error)"
        }
    }
}
