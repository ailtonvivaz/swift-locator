//
//  Provider.swift
//  Provider
//
//  Created by Ailton on 16/07/21.
//

import Foundation

typealias AnyLocatorResolve = LocatorResolve<Any>

struct Provider {
    public enum LifeCycle {
        case global
        case oneOf
    }
    
    private var cycle: LifeCycle
    private var resolve: AnyLocatorResolve?
    private var instance: Any?
    
    init(instance: Any) {
        self.cycle = .global
        self.resolve = nil
        self.instance = instance
    }
    
    init(cycle: LifeCycle, resolve: @escaping AnyLocatorResolve) {
        self.cycle = cycle
        self.resolve = resolve
        self.instance = nil
    }
    
    mutating func provide<Service>(from container: Locator, of type: Service.Type = Service.self) -> Service? {
        if let instance = instance as? Service {
            return instance
        }
        
        if let instance = resolve?(container) as? Service {
            if cycle == .global {
                self.instance = instance
            }
            return instance
        }
        
        return nil
    }
}
