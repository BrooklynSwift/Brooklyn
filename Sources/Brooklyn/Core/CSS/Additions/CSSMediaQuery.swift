//
//  CSSMediaQuery.swift
//
//
//  Created by Luki on 14/10/2024.
//

import Foundation

/// A struct that represents a CSS media query
public struct CSSMediaQuery {
	internal let condition: Condition
	internal let classes: [CSSClass]
	internal let variables: [CSSVariable]

	/// Designated initializer
	/// - Parameters:
	///		- condition: A `Condition` object that represents the media query's condition
	///		- classes: An array of `CSSClass` this query may contain, defaults to empty
	///		- variables: An array of `CSSVariables`this query may contain, defaults to empty
	public init(condition: Condition, classes: [CSSClass] = [], variables: [CSSVariable] = []) {
		self.condition = condition
		self.classes = classes
		self.variables = variables
	}

	/// An enum that represents a CSS media query condition
	@frozen
	public enum Condition {
		case minWidth(CSSDimension)
		case maxWidth(CSSDimension)

		var value: String {
			switch self {
				case .minWidth(let width): return "screen and (min-width: \(width.rawValue))"
				case .maxWidth(let width): return "screen and (max-width: \(width.rawValue))"
			}
		}
	}
}
