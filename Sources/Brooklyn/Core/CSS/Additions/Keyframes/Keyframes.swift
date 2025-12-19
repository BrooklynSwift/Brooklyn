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
	///		- name: A `String` that represents the keyframes' name
	///		- points: A closure that takes no arguments & returns an array of `KeyframePoint`
	public init(name: String, @CSSKeyframePointBuilder points: () -> [KeyframePoint]) {
		self.name = name
		self.points = points()
	}
}
