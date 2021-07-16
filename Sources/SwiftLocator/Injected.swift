//
//  Injected.swift
//  Injected
//
//  Created by Ailton on 16/07/21.
//

import Foundation

@propertyWrapper
public struct Injected<Service> {
    typealias DelayedInjection = () -> Service

    var service: Service?
    var delayed: DelayedInjection?

    public init(locator: Locator = .main) {
        delayed = { locator.get() }
    }

    public var wrappedValue: Service {
        mutating get {
            if let service = service {
                return service
            } else if let service = delayed?() {
                return service
            } else {
                fatalError()
            }
        }
    }
}
