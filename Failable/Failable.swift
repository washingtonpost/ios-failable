//  
//  Failable.swift
//
//  Copyright (c) 2016 The Washington Post
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
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
//  THE SOFTWARE.
//

import Foundation


/**
 Failable is an object returned in mappable completions, using the Either monad,
 the response is either successful or an error was encountered.

 - Success: The response and mapping was successful, resulting in Mappable data.
 - Failure: An error was encountered. The error that caused the failure.
 */
public enum Failable<T> {
    case Success(T)
    case Failure(ErrorType)

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
    public var error: ErrorType? {
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
