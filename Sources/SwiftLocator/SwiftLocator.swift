//
//  Locator.swift
//  Locator
//
//  Created by Ailton on 16/07/21.
//

import Foundation

public typealias LocatorResolve<T> = (Locator) -> T

public class Locator {
    static public var main = Locator()
    
    private var factories: [ObjectIdentifier: Provider] = [:]

    public init() {}

    deinit {
        reset()
    }
    
    public func reset() {
        factories.removeAll()
    }
    
    public func get<Service>(of type: Service.Type = Service.self) -> Service {
        guard var provider = self.factories[key(for: type)] else {
            fatalError("Unregistered Service: \(String(describing: Service.self))")
        }
        
        return provider.provide(from: self, of: Service.self)!
    }
    
    public func callAsFunction<Service>(of type: Service.Type = Service.self) -> Service { get() }
    
    private func key<T>(for type: T.Type) -> ObjectIdentifier { .init(type) }
    
    private func register<Service>(provider: Provider, type: Service.Type) {
        if isRegistered(type: type) {
            fatalError("Service is already registered: \(String(describing: Service.self))")
        }
        self.factories[key(for: type)] = provider
    }
    
    @discardableResult
    public func registerSingleton<Service>(_ instance: Service) -> Self {
        register(provider: .init(instance: instance), type: Service.self)
        return self
    }
    
    @discardableResult
    public func registerLazySingleton<Service>(_ resolve: @escaping LocatorResolve<Service>) -> Self {
        register(provider: .init(cycle: .global, resolve: resolve), type: Service.self)
        return self
    }
    
    @discardableResult
    public func registerFactory<Service>(_ resolve: @escaping LocatorResolve<Service>) -> Self {
        register(provider: .init(cycle: .oneOf, resolve: resolve), type: Service.self)
        return self
    }
    
    public func isRegistered<Service>(type: Service.Type) -> Bool { factories.keys.contains(key(for: type)) }
}
