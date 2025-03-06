//
//  CSSDimension.swift
//
//
//  Created by Luki on 10/10/2024.
//

import Foundation

/// A struct that represents a CSS dimension with a given value & its corresponding unit, such as `em`, `px`, `rem`, `vh`
public struct CSSDimension {
	public let rawValue: String

	/// Designated initializer
	/// - Parameters:
	///		- value: The CSS dimension value, e.g. `padding`
	///		- unit: The CSS unit, e.g. `px`
	public init(_ value: Float, unit: String) {
		self.rawValue = "\(value)\(unit)"
	}

	/// Designated initializer
	/// - Parameters:
	///		- custom: The CSS dimension value represented as a String, useful for values such as `-webkit-fill-available`
	public init(_ custom: String) {
		self.rawValue = custom
	}
}

public extension CSSDimension {
	/// Function that represents the CSS `px` unit
	/// - Parameters:
	///		- value: A `Float` that represents the value
	///	- Returns: `CSSDimension`
	static func px(_ value: Float) -> Self {
		"\(value)px"
	}

	/// Function that represents the CSS `vh` unit
	/// - Parameters:
	///		- value: A `Float` that represents the value
	/// - Returns: `CSSDimension`
	static func vh(_ value: Float) -> Self {
		"\(value)vh"
	}

	/// Function that represents the CSS `dvh` unit
	/// - Parameters:
	///		- value: A `Float` that represents the value
	/// - Returns: `CSSDimension`
	static func dvh(_ value: Float) -> Self {
		"\(value)dvh"
	}

	/// Function that represents the CSS `em` unit
	/// - Parameters:
	///		- value: A `Float` that represents the value
	/// - Returns: `CSSDimension`
	static func em(_ value: Float) -> Self {
		"\(value)em"
	}

	/// Function that represents the CSS `rem` unit
	/// - Parameters:
	///		- value: A `Float` that represents the value
	/// - Returns: `CSSDimension`
	static func rem(_ value: Float) -> Self {
		"\(value)rem"
	}

	/// Variable that represents the CSS `-webkit-fill-available` value
	/// - Returns: `CSSDimension`
	static var webkitFillAvailable: Self {
		return "-webkit-fill-available"
	}
}

// MARK: - ExpressibleByStringInterpolation

extension CSSDimension: ExpressibleByStringInterpolation {
	public typealias StringLiteralType = String

	public init(stringLiteral value: String) {
		self.rawValue = value
	}
}

// MARK: - RawRepresentable

extension CSSDimension: RawRepresentable {
	public init?(rawValue: String) {
		assertionFailure("init(rawValue:) has not been implemented")
		return nil
	}
}
