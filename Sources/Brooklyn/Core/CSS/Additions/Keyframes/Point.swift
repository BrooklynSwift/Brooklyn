//
//  Point.swift
//  Brooklyn
//
//  Created by Luki on 19/12/2025.
//

import Foundation

/// A struct that represents a set of CSS keyframe points
public struct KeyframePoint {
	internal let percentage: String
	internal let value: Modifier

	/// Designated initializer
	/// - Parameters:
	///		- percentage: A `Double` that represents the percentage
	///		- value: A `Modifier` object that represents the value, e.g. `translate: (2px, 0)`
	public init(percentage: Double, value: Modifier) {
		self.percentage = "\(percentage)%"
		self.value = value
	}
}
