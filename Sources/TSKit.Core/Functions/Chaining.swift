// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

// TODO: Early access. No documentation, no usages.
// TODO: Implement different combinations of optional and non-optional inputs and outputs.

precedencegroup ChainingPrecedence {
    lowerThan: AdditionPrecedence
    higherThan: AssignmentPrecedence
    associativity: left
}

infix operator => : ChainingPrecedence
infix operator =>? : ChainingPrecedence
infix operator ==> : ChainingPrecedence
infix operator ==>? : ChainingPrecedence

public func ==><A, B>(_ lhs: A, _ rhs: (A) throws -> B) rethrows -> B {
    try rhs(lhs)
}

@discardableResult
public func ==><A>(_ lhs: A, _ rhs: (A) throws -> Void) rethrows -> A {
    try rhs(lhs)
    return lhs
}

@discardableResult
public func ==><A>(_ lhs:  () throws -> A, _ rhs: (A) throws -> Void) rethrows -> A {
    let a = try lhs()
    try rhs(a)
    return a
}

public func ==><A, B>(_ lhs: () throws -> A, _ rhs: (A) throws -> B) rethrows -> B {
    try rhs(try lhs())
}

public func ==>?<A, B>(_ lhs: A?, _ rhs: (A) throws -> B?) rethrows -> B? {
    try lhs.flatMap(rhs)
}

public func ==>?<A, B>(_ lhs: () throws -> A?, _ rhs: (A) throws -> B?) rethrows -> B? {
    try lhs().flatMap(rhs)
}

public func =><A, B, C>(_ lhs: @escaping (A) -> B, _ rhs: @escaping (B) -> C) -> (A) -> C {
    { rhs(lhs($0)) }
}

public func =><A, B, C>(_ lhs: @escaping (A) -> B?, _ rhs: @escaping (B) -> C?) -> (A) -> C? {
    { lhs($0).flatMap(rhs) }
}

public func =><A, B>(_ lhs: @escaping (A) -> B, _ rhs: @escaping (B) -> Void) -> (A) -> B {
    {
        let b = lhs($0)
        rhs(b)
        return b
    }
}

public func =><A>(_ lhs: @escaping () -> A, _ rhs: @escaping (A) -> Void) -> () -> A {
    {
        let a = lhs()
        rhs(a)
        return a
    }
}

public func =>?<A, B>(_ lhs: @escaping (A) -> B?, _ rhs: @escaping (B) -> Void) -> (A) -> B? {
    {
        let b = lhs($0)
        b.flatMap(rhs)
        return b
    }
}

public func =>?<A>(_ lhs: @escaping () -> A?, _ rhs: @escaping (A) -> Void) -> () -> A? {
    {
        let a = lhs()
        a.flatMap(rhs)
        return a
    }
}
