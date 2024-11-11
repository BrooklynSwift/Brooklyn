//
// Link.swift
//
//
//  Created by Luki on 16/10/2024.
//

import Foundation

/// A struct that provides syntatic sugar to represent an HTML anchor tag
public struct Link: CustomRenderable {
	private let content: String
	private let target: String
	
	public var attributes: HTMLAttributes = .init()
	
	internal var body: [HTMLRenderable] {
		var anchor = A {
			Text(content)
		}
		anchor.attributes = attributes
		anchor.attributes.href = target
		return [anchor]
	}
	
	/// Designated initializer
	/// - Parameters:
	///		- content: A string that represents the link's title
	///		- target: A string that represents the link's target
	public init(_ content: String, target: String) {
		self.content = content
		self.target = target
	}
}
