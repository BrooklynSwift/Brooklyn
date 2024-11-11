//
//  CSSRule.swift
//
//
//  Created by Luki on 04/10/2024.
//

import Foundation

/// A struct that represents a CSS rule, consisting of a selector and (n) number of properties
/// 
/// For example:
///
///		div {
/// 		align-items: center;
/// 		display: flex;
///			flex-direction: column;
///		}
public struct CSSRule {
	let selector: String
	let properties: [CSSProperty]


	/// Designated initializer
	/// - Parameters:
	///		- selector: A string that represents the selector's name
	///		- properties: A closure that takes no arguments & returns an array of `CSSProperty`
	public init(selector: String, @CSSBuilder properties: () -> [CSSProperty]) {
		self.selector = selector
		self.properties = properties()
	}
}
