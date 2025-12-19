//
//  Modifier.swift
//  Brooklyn
//
//  Created by Luki on 19/12/2025.
//

import Foundation

/// A struct that represents a CSS value that can be animated using `@keyframes`, e.g. `opacity`
public struct Modifier {
	public let rawValue: String
	internal let property: String
}

// MARK: - ExpressibleByStringLiteral

extension Modifier: ExpressibleByStringLiteral {
	public init(stringLiteral value: String) {
		self.init(rawValue: value)!
	}
}

// MARK: - RawRepresentable

extension Modifier: RawRepresentable {
	public init?(rawValue: String) {
		let components = rawValue.split(separator: ":")
		guard components.count == 2 else { fatalError("This is not a valid Modifier format") }

		self.property = components.first!.trimmingCharacters(in: .whitespaces)
		self.rawValue = components[1].trimmingCharacters(in: .whitespaces)
	}
}

// MARK: - Modifiers

public extension Modifier {
	/// A static function that creates a CSS transform for translating an element
	/// - Parameters:
	///		- x: A `CSSDimension` value that represents the value along the X-axis, defaults to 0px
	///		- y: A `CSSDimension` value that represents the value along the Y-axis, defaults to 0px
	/// - Returns: `Modifier`
	static func translate(x: CSSDimension = .px(0), y: CSSDimension = .px(0)) -> Self {
		.init(stringLiteral: "transform: translate(\(x.rawValue), \(y.rawValue))")
	}

	/// A static function that creates an arbitrary CSS property that can be used in a set of keyframes
	/// - Parameters:
	///		- property: A `String` that represents the property's name
	///		- value: A `String` that represents the property's value
	/// - Returns: `Modifier`
	static func property(_ property: String, _ value: String) -> Self {
		.init(stringLiteral: "\(property):\(value)")
	}
}
