//
//  CSSAnimation.swift
//
//
//  Created by Luki on 15/10/2024.
//

import Foundation

/// A struct that represents a CSS animation
public struct CSSAnimation {
	internal let name: String
	internal let duration: Duration

	internal var timingFunction: TimingFunction = .ease()
	internal var delay: Double = 0
	internal var iterationCount = 1
	internal var direction: Direction = .normal

	/// Designated initializer
	/// - Parameters:
	///		- name: A string that represents the animation's name
	///		- duration: A `Duration` object that represents the animation's duration
	///		- timingFunction: A `TimingFunction` object that represents the animation's timing function
	///		- delay: A double that represents the animation's delay
	///		- iterationCount: An integer that represents the animation's iteration count
	///		- direction: An integer that represents the animation's direction
	public init(
		name: String,
		duration: Duration,
		timingFunction: TimingFunction = .ease(),
		delay: Double = 0,
		iterationCount: Int = 1,
		direction: Direction = .normal
	) {
		self.name = name
		self.duration = duration
		self.timingFunction = timingFunction
		self.delay = delay
		self.iterationCount = iterationCount
		self.direction = direction
	}

	internal var description: String {
		var animationPieces = [name, duration.rawValue]

		if timingFunction != .ease() {
			animationPieces.append(timingFunction.rawValue)
		}

		if delay > 0 {
			animationPieces.append("\(delay)")
		}
		if iterationCount != 1 {
			animationPieces.append("\(iterationCount)")
		}
		if direction != .normal {
			animationPieces.append(direction.rawValue)
		}

		return animationPieces.compactMap { $0 }.joined(separator: " ")
	}
}

// MARK: - Duration

public extension CSSAnimation {
	/// A struct that represents a duration value for a CSS animation
	struct Duration: RawRepresentable {
		public let rawValue: String

		public init(rawValue: String) {
			self.rawValue = rawValue
		}
	}
}

public extension CSSAnimation.Duration {
	/// Function that represents the `ms` unit for a CSS animation's duration
	/// - Parameter value: A double that represents the value in miliseconds
	/// - Returns: `Duration`
	static func ms(_ value: Double) -> Self {
		.init(rawValue: "\(value)ms")
	}

	/// Function that represents the `s` unit for a CSS animation's duration
	/// - Parameter value: A double that represents the value in seconds
	/// - Returns: `Duration`
	static func s(_ value: Double) -> Self {
		.init(rawValue: "\(value)s")
	}
}

// MARK: - TimingFunction

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
	/// Function that represents the `ease` timing function for a CSS animation
	/// - Returns: `TimingFunction`
	static func ease() -> Self {
		return "ease"
	}

	/// Function that represents the `linear` timing function for a CSS animation
	/// - Returns: `TimingFunction`
	static func linear() -> Self {
		return "linear"
	}
}

// MARK: - Duration

public extension CSSAnimation {
	/// An enum that represents the direction for a CSS animation
	enum Direction: String {
		case normal
	}
}
