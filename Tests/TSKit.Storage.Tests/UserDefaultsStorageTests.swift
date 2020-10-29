import XCTest
@testable import TSKit_Storage

class UserDefaultsStorageTests: TypedStorageTests {

    private let userDefaultsStorage = UserDefaultsStorage()
    
    override var storage: AnyTypedStorage { userDefaultsStorage }
}
