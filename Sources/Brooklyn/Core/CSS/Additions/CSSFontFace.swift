//
//  CSSFontFace.swift
//  
//
//  Created by Luki on 07/10/2024.
//

import Foundation

/// A struct that represents a CSS `@font-face`
public struct CSSFontFace {
	internal let family: FontFamily
	internal let weight: FontWeight
	internal let url: String

	/// Designated initializer
	/// - Parameters:
	///		- family: The font family
	///		- weight: The font weight, defaulting to normal, i.e. "400"
	///		- url: The source url for the font face
	public init(family: FontFamily, weight: FontWeight = .normal, url: String) {
		self.family = family
		self.weight = weight
		self.url = url
	}

	/// A struct that represents a font family for a given CSS font face
	public struct FontFamily {
		let name: String

		/// Designated initializer
		/// - Parameters:
		///		- name: The family name
		public init(name: String) {
			self.name = name
		}
	}

	/// Enum that represents most of the CSS font weight values
	public enum FontWeight: String {
		case ultraLight = "100"
		case thin = "200"
		case light = "300"
		case normal
		case medium = "500"
		case semibold = "600"
		case bold
		case heavy = "800"
		case black = "900"
		case inherit
		case initial
		case unset
	}
}
