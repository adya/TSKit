// - Since: 01/21/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Storage/blob/master/LICENSE.md

import Foundation

/// iCloud Storage.
@available(iOS 8.0, *)
public class UbiquitousStorage : AnyDynamicStorage {

    private let storage: NSUbiquitousKeyValueStore
    
    /// Initializes storage with provided `ubiquitous` instance to be used internally.
    /// 
    /// - Parameter ubiquitous: UbiquitousKeyValueStore instance to be used as a baking storage.
    ///                         Defaults to `UbiquitousKeyValueStore.default`.
    public init(ubiquitous: NSUbiquitousKeyValueStore = .default) {
        self.storage = ubiquitous
    }
    
    public func value(forKey key: String) -> Any? {
        storage.value(forKey: key)
    }
    
    public func set(_ value: Any, forKey key: String) -> Bool {
        storage.set(value, forKey: key)
        return true
    }
    
    public func removeValue(forKey key: String) -> Bool {
        storage.removeObject(forKey: key)
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
        dictionary.count
    }
    
    public var dictionary: [String : Any] {
        storage.dictionaryRepresentation
    }
    
    deinit {
        storage.synchronize()
    }
}
