//
//  CSSVariable.swift
//
//
//  Created by Luki on 14/10/2024.
//

import Foundation

/// A struct that represents a CSS variable, e.g. `--some-color: black;`
public struct CSSVariable {
	internal let name: String
	internal let value: String

	/// Designated initializer
	/// - Parameters:
	///		- name: A string that represents the variable's name
	///		- value: A string that represents the variable's value
	public init(name: String, value: String) {
		self.name = name
		self.value = value
	}
}
