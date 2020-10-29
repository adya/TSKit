import Foundation
import XCTest
import TSKit_Core
@testable import TSKit_Storage

class TypedStorageTests: XCTestCase {
        
    var storage: AnyTypedStorage {
        fatalError("Provide storage instance to be tested")
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        storage.removeAll()
        super.tearDown()
    }
}

// MARK: - Setter
extension TypedStorageTests {
    
    func testBoolIntegrity() {
        XCTAssertIntegrity(with: true)
        XCTAssertIntegrity(with: false)
    }
    
    func testIntIntegrity() {
        XCTAssertIntegrity(with: 5)
        XCTAssertIntegrity(with: Int.min)
        XCTAssertIntegrity(with: Int.max)
    }
    
    func testDecimalIntegrity() {
        XCTAssertIntegrity(with: 5 as Decimal)
        XCTAssertIntegrity(with: 5.55 as Decimal)
    }
    
    func testDoubleIntegrity() {
        XCTAssertIntegrity(with: 5.55 as Double)
    }
    
    func testFloatIntegrity() {
        XCTAssertIntegrity(with: 5.55 as Float)
    }
    
    func testDataIntegrity() {
        XCTAssertIntegrity(with: Data([0x11, 0x22, 0x33, 0x44]))
    }
    
    func testStringIntegrity() {
        XCTAssertIntegrity(with: "My text", key: "shortText")
        XCTAssertIntegrity(with: String.random(count: 100), key: "longText")
        XCTAssertIntegrity(with: "", key: "emptyText")
    }
}

// MARK: - Updates
extension TypedStorageTests {
    
    func testUpdate() {
        let key = "Value"
        guaranteedSet(true, forKey: key)
        
        XCTAssertIntegrity(with: false, key: key)
    }
}

// MARK: - Value testing
extension TypedStorageTests {
    
    func testHasValue() {
        let key = "Value"
        
        XCTAssert(!storage.hasValue(forKey: key), "Storage must not contain value for key '\(key)' prior to it being set")
        
        guaranteedSet(true, forKey: key)
        
        XCTAssert(storage.hasValue(forKey: key), "Storage should contain value for key '\(key)' after it was set")
        XCTAssert(!storage.hasValue(forKey: "UnrelatedValue"), "Storage must not contain unrelated values that was not stored in it")
        
        guaranteedRemove(forKey: key)
        XCTAssert(!storage.hasValue(forKey: key), "Storage must not contain value for key '\(key)' after it was removed")
        
    }
    
    func testCount() {
        let keys = ["First", "Second", "Third"]
        let modifiedKey = keys.first!
        
        guaranteedPopulateValues(forKeys: keys)
        
        XCTAssert(storage.count == keys.count, "Count doesn't match number of added items")
        
        guaranteedSet(true, forKey: modifiedKey)
        
        XCTAssert(storage.count == keys.count, "Count must remain the same after updating existing value")
        
        guaranteedRemove(forKey: modifiedKey)
        
        XCTAssert(storage.count == keys.count - 1, "Count must be decremented after removing a single value")
        
        guaranteedRemoveAll()
        
        XCTAssert(storage.count == 0, "storage.count must be `0` after removing all values")
    }
}

// MARK: - Removals
extension TypedStorageTests {
    
    func testRemoveAll() {
        let keys = ["First", "Second", "Third"]
        guaranteedPopulateValues(forKeys: keys)
        
        let allRemoved = storage.removeAll()
        let isEmpty = keys.allSatisfy { !storage.hasValue(forKey: $0) }
        
        XCTAssert(allRemoved, "Failed to remove all values")
        XCTAssert(isEmpty, "Storage is not empty after removing all values")
    }
    
    func testRemove() {
        let toBeRemovedKey = "Value"
        let toBeRetainedKey = "IntValue"
        let retainedValue = 5
        storage.set(true, forKey: toBeRemovedKey)
        storage.set(retainedValue, forKey: toBeRetainedKey)
        
        let wasRemoved = storage.removeValue(forKey: toBeRemovedKey)
        
        XCTAssert(wasRemoved, "Failed to remove value for '\(toBeRemovedKey)' key")
        XCTAssert(!storage.hasValue(forKey: toBeRemovedKey), "Value is still present in the storage")
        XCTAssert(storage.intValue(forKey: toBeRetainedKey) == retainedValue, "Removal has affected unrelated value")
    }
}

private extension TypedStorageTests {
    
    /// XCTAsserts that specifief `value` won't be modified when being stored and read afterwards.
    func XCTAssertIntegrity<T>(with value: T, key: String? = nil) {
        let key = key ?? "\(T.self)"
        XCTAssert(set(value, forKey: key), "Failed to set \(key) value")
        XCTAssert(match(value, forKey: key), "\(key) integrity not preserved")
    }
    
    func set<T>(_ value: T, forKey key: String) -> Bool {
        switch value {
            case let value as String: return storage.set(value, forKey: key)
            case let value as Int: return storage.set(value, forKey: key)
            case let value as Decimal: return storage.set(value, forKey: key)
            case let value as Double: return storage.set(value, forKey: key)
            case let value as Float: return storage.set(value, forKey: key)
            case let value as Bool: return storage.set(value, forKey: key)
            case let value as Data: return storage.set(value, forKey: key)
            case let value as NSNumber: return storage.set(value, forKey: key)
            default: return false
        }
    }
    
    func match<T>(_ value: T, forKey key: String) -> Bool {
        switch value {
            case let value as String: return storage.stringValue(forKey: key) == value
            case let value as Int: return storage.intValue(forKey: key) == value
            case let value as Decimal: return storage.decimalValue(forKey: key) == value
            case let value as Double: return storage.doubleValue(forKey: key) == value
            case let value as Float: return storage.floatValue(forKey: key) == value
            case let value as Bool: return storage.boolValue(forKey: key) == value
            case let value as Data: return storage.dataValue(forKey: key) == value
            case let value as NSNumber: return storage.numberValue(forKey: key) == value
            default: return false
        }
    }
}

// MARK: - Guaranteed calls
private extension TypedStorageTests {
    
    /// Populates storage with `true` values for specified keys.
    func guaranteedPopulateValues(forKeys keys: [String]) {
        XCTAssert(keys.allSatisfy { set(true, forKey: $0) }, "`storage.set(_:,forKey:)` is malfunctioning")
    }
    
    func guaranteedRemove(forKey key: String) {
        XCTAssert(storage.removeValue(forKey: key), "`storage.removeValue(forKey:)` is malfunctioning")
    }
    
    func guaranteedRemoveAll() {
        XCTAssert(storage.removeAll(), "`storage.removeAll()` is malfunctioning")
    }
    
    func guaranteedSet<T>(_ value: T, forKey key: String) {
        XCTAssert(set(value, forKey: key), "`storage.set(_:,forKey:)` is malfunctioning")
    }
}
