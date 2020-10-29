// - Since: 01/21/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Storage/blob/master/LICENSE.md

import Foundation

/// iCloud Storage.
@available(iOS 8.0, *)
public class UbiquitousStorage : AnyDynamicStorage {

    private var storage = NSUbiquitousKeyValueStore.default
    
    public func value(forKey key: String) -> Any? {
        storage.value(forKey: key)
    }
    
    public func set(_ value: Any, forKey key: String) -> Bool {
        storage.set(value, forKey: key)
        storage.synchronize()
        return true
    }
    
    public func removeValue(forKey key: String) -> Bool {
        storage.removeObject(forKey: key)
        storage.synchronize()
        return true
    }
    
    public func removeAll() -> Bool {
        dictionary.keys.forEach {
            storage.removeObject(forKey: $0)
        }
        storage.synchronize()
        return true
    }
    
    public var count: Int {
        return dictionary.count
    }
    
    public var dictionary: [String : Any] {
        return storage.dictionaryRepresentation
    }
    
    deinit {
        storage.synchronize()
    }
}

// MARK: - Typed setters
public extension UbiquitousStorage {
    
    @discardableResult
    func set(_ value: String, forKey key: String) -> Bool {
        storage.set(value, forKey: key)
        return true
    }
    
    @discardableResult
    func set(_ value: Int, forKey key: String) -> Bool {
        storage.set(value, forKey: key)
        storage.synchronize()
        return true
    }
    
    @discardableResult
    func set(_ value: Double, forKey key: String) -> Bool {
        storage.set(value, forKey: key)
        return true
    }
    
    @discardableResult
    func set(_ value: Decimal, forKey key: String) -> Bool {
        storage.set(value, forKey: key)
        return true
    }
    
    @discardableResult
    func set(_ value: Float, forKey key: String) -> Bool {
        storage.set(value, forKey: key)
        return true
    }
    
    @discardableResult
    func set(_ value: Bool, forKey key: String) -> Bool {
        storage.set(value, forKey: key)
        return true
    }
    
    @discardableResult
    func set(_ value: NSNumber, forKey key: String) -> Bool {
        storage.set(value, forKey: key)
        return true
    }
    
    @discardableResult
    func set(_ value: Data, forKey key: String) -> Bool {
        storage.set(value, forKey: key)
        return true
    }
}

// MARK: - Typed getters
public extension UbiquitousStorage {
    
    func intValue(forKey key: String) -> Int? {
        numberValue(forKey: key)?.intValue
    }
    
    func decimalValue(forKey key: String) -> Decimal? {
        numberValue(forKey: key)?.decimalValue
    }
    
    func doubleValue(forKey key: String) -> Double? {
        numberValue(forKey: key)?.doubleValue
    }
    
    func floatValue(forKey key: String) -> Float? {
        numberValue(forKey: key)?.floatValue
    }
    
    func boolValue(forKey key: String) -> Bool? {
        numberValue(forKey: key)?.boolValue
    }
    
    func numberValue(forKey key: String) -> NSNumber? {
        value(forKey: key) as? NSNumber
    }
}
