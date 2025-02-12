//
//  CSSMediaQuery.swift
//
//
//  Created by Luki on 14/10/2024.
//

import Foundation

/// A struct that represents a CSS media query
public struct CSSMediaQuery {
	internal let conditions: [Condition]
	internal let classes: [CSSClass]
	internal let variables: [CSSVariable]

	/// Designated initializer
	/// - Parameters:
	///		- conditions: An array of `Condition` objects that represents the media query's conditions
	///		- classes: An array of `CSSClass` this query may contain, defaults to empty
	///		- variables: An array of `CSSVariables`this query may contain, defaults to empty
	public init(conditions: [Condition], classes: [CSSClass] = [], variables: [CSSVariable] = []) {
		self.conditions = conditions
		self.classes = classes
		self.variables = variables
	}
}

public extension CSSMediaQuery {
	/// A struct that represents a CSS media query condition
	struct Condition {
		internal let type: String
		internal let value: String

		/// Designated initializer
		/// - Parameters:
		///		- type: A string that represents the media query's condition type
		///		- value: A string that represents the media query's condition value
		public init(type: String, value: String) {
			self.type = type
			self.value = value
		}
	}
}

public extension CSSMediaQuery.Condition {
	/// Function that represents the `max-width` condition
	/// - Parameter value: A `CSSDimension` object that represents the dimension (e.g., "600px")
	/// - Returns: `Condition`
	static func maxWidth(_ value: CSSDimension) -> Self {
		.init(type: "max-width", value: value.rawValue)
	}

	/// Function that represents the `min-width` condition
	/// - Parameters:
	///		- value: A `CSSDimension` object that represents the dimension (e.g., "600px")
	/// - Returns: `Condition`
	static func minWidth(_ value: CSSDimension) -> Self {
		.init(type: "min-width", value: value.rawValue)
	}

	/// Function that represents the `prefers-reduced-motion` condition
	/// - Parameters:
	///		- value: A string that represents the preference value
	/// - Returns: `Condition`
	static func prefersReducedMotion(_ value: String = "") -> Self {
		.init(type: "prefers-reduced-motion", value: value)
	}

	///	Function that represents the `screen` condition
	///	- Returns: `Condition`
	static func screen() -> Self {
		.init(type: "screen", value: "")
	}
}
