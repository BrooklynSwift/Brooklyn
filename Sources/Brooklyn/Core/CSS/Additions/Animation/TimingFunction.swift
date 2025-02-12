//
//  TimingFunction.swift
//
//
//  Created by Luki on 02/12/2024.
//

import Foundation

public extension CSSAnimation {
	/// A struct that represents a timing function for a CSS animation
	struct TimingFunction: RawRepresentable, ExpressibleByStringLiteral {
		public let rawValue: String

		public init(rawValue: String) {
			self.rawValue = rawValue
		}

		public init(stringLiteral value: StringLiteralType) {
			self.rawValue = value
		}
	}
}

public extension CSSAnimation.TimingFunction {
	/// Function that represents the `cubic-bezier` timing function for a CSS animation
	/// - Parameters:
	///		- x1: A Double that represents the x-axis coordinate of the first control point. It must be between 0 & 1
	///		- y1: A Double that represents the y-axis coordinate of the first control point
	///		- x2: A Double that represents the x-axis coordinate of the second control point. It must be between 0 & 1
	///		- y2: A Double that represents the y-axis coordinate of the second control point
	/// - Returns: `TimingFunction`
	static func cubicBezier(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Self {
		return .init(stringLiteral: "cubic-bezier(\(x1), \(y1), \(x2), \(y2))")
	}

	/// Function that represents the `ease` timing function for a CSS animation
	/// - Returns: `TimingFunction`
	static func ease() -> Self {
		return "ease"
	}

	/// Function that represents the `ease-in` timing function for a CSS animation
	/// - Returns: `TimingFunction`
	static func easeIn() -> Self {
		return "ease-in"
	}

	/// Function that represents the `ease-in-out` timing function for a CSS animation
	/// - Returns: `TimingFunction`
	static func easeInOut() -> Self {
		return "ease-in-out"
	}

	/// Function that represents the `ease-out` timing function for a CSS animation
	/// - Returns: `TimingFunction`
	static func easeOut() -> Self {
		return "ease-out"
	}

	/// Function that represents the `linear` timing function for a CSS animation
	/// - Returns: `TimingFunction`
	static func linear() -> Self {
		return "linear"
	}
}
