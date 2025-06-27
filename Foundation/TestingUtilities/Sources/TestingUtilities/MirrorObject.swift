//
//  MirrorObject.swift
//  TestingUtilities
//
//  Created by David Londono on 26/06/2025.
//  Copyright © 2025 uala_cities. All rights reserved.
//

import Foundation

/// Class that exposes read-only reflection of private properties of entities.
///
/// Assume that you have the following class:
/// ```
/// class Foobar {
///    ...
///
///    private var someProperty: NSDictionary
///
///    ...
/// }
/// ```
/// And in a test case, you want to validate the contents of `someProperty`. For this case,
/// you'll want to subclass `MirrorObject` and expose a read-only property, like the following:
///
/// ```
/// class FoobarMirror: MirrorObject {
///   var someProperty: NSDictionary { extract() }
///
///   init(reflecting instance: Foobar) {
///      super.init(reflecting: instance)
///   }
/// }
/// ```
///
/// Then, in order to read the values of `someProperty` in a test, you can:
/// ```
/// let foobar = Foobar()
///
/// ... things happen
///
/// let mirror = FoobarMirror(reflecting: foobar)
/// let privateProperty = mirror.someProperty // (here's someProperty)
/// ```
/// And you'll have read-only access of the value.
///
///
open class MirrorObject {
    let mirror: Mirror

    public init(reflecting: Any) {
        mirror = Mirror(reflecting: reflecting)
    }

    public func extract<T>(variableName: StaticString = #function) -> T? {
        extract(variableName: variableName, mirror: mirror)
    }

    private func extract<T>(variableName: StaticString, mirror: Mirror?) -> T? {
        guard let mirror = mirror else {
            return nil
        }

        guard let descendant = mirror.descendant("\(variableName)") as? T else {
            return extract(variableName: variableName, mirror: mirror.superclassMirror)
        }

        return descendant
    }
}
