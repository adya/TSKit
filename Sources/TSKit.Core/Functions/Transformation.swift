// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// Performs `transformation` on specified `object` using `inout` closure.
///
/// This method  is used to modify existing immutable `object` by creating a copy of it and applying
/// provided `transformation`. It is designed to operate on objects of **value types**,
/// to reduce repeatitions of the same code costruct.
/// **Reference types** are supported, however `transform` gives no benefits in these cases,
/// as you can directly modify immutable **reference type** variables.
/// - Parameter object: An object to which `transformation` will be applied.
/// - Parameter transformation: `inout` closure that performs transformation of the `object`.
/// - Note: When passing reference type objects to this method
///         it will apply transformation to and will return the same object.
/// - Returns: Mutated object after `transformation`.
public func transform<ObjectType>(_ object: ObjectType,
                                  _ transformation: (inout ObjectType) -> Void) -> ObjectType {
    var object = object
    transformation(&object)
    return object
}
