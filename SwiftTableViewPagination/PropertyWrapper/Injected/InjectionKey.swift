//
//  InjectionKey.swift
//  SwiftTableViewPagination
//
//  Created by Yuki Okudera on 2021/12/19.
//

import Foundation

public protocol InjectionKey {

    /// The associated type representing the type of the dependency injection key's value.
    associatedtype Value

    /// The default value for the dependency injection key.
    static var currentValue: Value { get set }
}
