//
//  CSSProperty.swift
//
//
//  Created by Luki on 04/10/2024.
//

import Foundation

/// A struct that represents a CSS property with its respective value, e.g. `display: flex;`
public struct CSSProperty {
	let name: String
	let value: String

	/// Designated initializer
	/// - Parameters:
	///		- name: A `Key` object that represents the property's name
	///		- value: A string that represents the property's value
	public init(name: Key, value: String) {
		self.name = name.rawValue
		self.value = value
	}

	/// Designated initializer
	/// - Parameters:
	///		- name: A string that represents the property's name
	///		- value: A string that represents the property's value
	public init(name: String, value: String) {
		self.name = name
		self.value = value
	}

	/// A custom initializer that takes a `CSSAnimation` object
	/// - Parameters:
	///		- animation: A `CSSAnimation` object that represents a CSS animation
	public init(animation: CSSAnimation) {
		self.name = "animation"
		self.value = animation.description
	}
}

public extension CSSProperty {
	/// An enum that represents a CSS property's name
	@frozen enum Key: String {
		case alignItems = "align-items"
		case backgroundColor = "background-color"
		case borderRadius = "border-radius"
		case bottom
		case color
		case content
		case display
		case flexDirection = "flex-direction"
		case fontFamily = "font-family"
		case fontSize = "font-size"
		case fontWeight = "font-weight"
		case height
		case justifyContent = "justify-content"
		case left
		case margin
		case padding
		case position
		case textAlign = "text-align"
		case textDecoration = "text-decoration"
		case transform
		case transition
		case width
	}
}
