//
//  CSSKeyframes.swift
//
//
//  Created by Luki on 14/10/2024.
//

import Foundation

/// A struct that represents a set of CSS keyframes
///
/// For example:
///
///		@keyframes fade {
///			0% {
///				opacity: 0;
///			}
/// 		100% {
/// 			opacity: 1;
/// 		}
///		}
public struct CSSKeyframes {
	internal let name: String
	internal let points: [KeyframePoint]

	/// Designated initializer
	/// - Parameters:
	///		- name: A string that represents the keyframes' name
	///		- points: A closure that takes no arguments & returns an array of `KeyframePoint`
	public init(name: String, @CSSKeyframePointBuilder points: () -> [KeyframePoint]) {
		self.name = name
		self.points = points()
	}
}

/// A struct that represents a set of CSS keyframe points
public struct KeyframePoint {
	internal let percentage: String
	internal let value: Modifier

	/// Designated initializer
	/// - Parameters:
	///		- percentage: A double that represents the percentage
	///		- value: A `Modifier` object that represents the value, e.g. `translate: (2px, 0)`
	public init(percentage: Double, value: Modifier) {
		self.percentage = "\(percentage)%"
		self.value = value
	}
}

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
	///		- x: The translation value along the X-axis. Defaults to 0px
	///		- y: The translation value along the Y-axis. Defaults to 0px
	/// - Returns: `Modifier`
	static func translate(x: CSSDimension = .px(0), y: CSSDimension = .px(0)) -> Self {
		.init(stringLiteral: "transform: translate(\(x.rawValue), \(y.rawValue))")
	}

	/// A static function that creates an arbitrary CSS property that can be used in a set of keyframes
	/// - Parameters:
	///		- property: A string that represents the property's name
	///		- value: A string that represents the property's value
	/// - Returns: `Modifier`
	static func property(_ property: String, _ value: String) -> Self {
		.init(stringLiteral: "\(property):\(value)")
	}
}
