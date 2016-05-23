//
//  Failable.swift
//  Pods
//
//  Created by Davis, William on 5/23/16.
//
//

import Foundation

public enum Failable<T> {
    case Success(T)
    case Failure(NSError)
}