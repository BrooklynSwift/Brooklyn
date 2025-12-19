//
//  CSSProperty.swift
//
//
//  Created by Luki on 04/10/2024.
//

import Foundation

/// A struct that represents a CSS property with its respective value, e.g. `display: flex;`
public struct CSSProperty {
	public let name, value: String

	/// Designated initializer
	/// - Parameters:
	///		- name: A `Key` object that represents the property's name
	///		- value: A `RawRepresentable` object that represents the property's value
	public init<R: RawRepresentable>(name: Key, value: R) where R.RawValue == String {
		self.name = name.rawValue
		self.value = value.rawValue
	}

	/// Designated initializer
	/// - Parameters:
	///		- name: A `Key` object that represents the property's name
	///		- value: A `String` that represents the property's value
	public init(name: Key, value: String) {
		self.name = name.rawValue
		self.value = value
	}

	/// A custom initializer that takes a `CSSAnimation` object
	/// - Parameters:
	///   - animation: A `CSSAnimation` object that represents a CSS animation
	public init(animation: CSSAnimation) {
		self.name = "animation"
		self.value = animation.description
	}
}

public extension CSSProperty {
	/// A struct that represents a CSS property's name
	struct Key: ExpressibleByStringLiteral, RawRepresentable {
		public let rawValue: String

		public init(rawValue: String) {
			self.rawValue = rawValue
		}

		public init(stringLiteral value: String) {
			self.rawValue = value
		}
	}
}

@MainActor
public extension CSSProperty.Key {
	static let alignItems: Self = "align-items",
			   backgroundColor: Self = "background-color",
			   borderRadius: Self = "border-radius",
			   bottom: Self = "bottom",
			   color: Self = "color",
			   content: Self = "content",
			   display: Self = "display",
			   flexDirection: Self = "flex-direction",
			   fontFamily: Self = "font-family",
			   fontSize: Self = "font-size",
			   fontWeight: Self = "font-weight",
			   height: Self = "height",
			   justifyContent: Self = "justify-content",
			   left: Self = "left",
			   margin: Self = "margin",
			   padding: Self = "padding",
			   position: Self = "position",
			   textAlign: Self = "text-align",
			   textDecoration: Self = "text-decoration",
			   transform: Self = "transform",
			   transition: Self = "transition",
			   width: Self = "width"
}
