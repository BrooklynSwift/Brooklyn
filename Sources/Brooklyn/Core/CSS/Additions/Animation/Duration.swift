//
//  Duration.swift
//  
//
//  Created by Luki on 02/12/2024.
//

import Foundation

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
	/// - Parameter value: A double that represents the value in milliseconds
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
