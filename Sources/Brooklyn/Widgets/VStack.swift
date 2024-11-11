//
//  VStack.swift
//
//
//  Created by Luki on 12/10/2024.
//

import Foundation

/// A struct that provides syntactic sugar to represent a CSS flex container with a vertical layout
public struct VStack: CustomRenderable {
	public var attributes: HTMLAttributes = .init()
	internal let children: () -> [HTMLRenderable]

	internal var body: [HTMLRenderable] {
		var div = Div(children)
		div.attributes = attributes
		return [div]
	}

	/// Designated initializer
	/// - Parameters:
	/// 	- children: Escaping closure that takes no arguments & returns an array of `HTMLRenderable`, which represents the children for this object
	public init(@HTMLBuilder children: @escaping () -> [HTMLRenderable]) {
		self.children = children
		self.attributes.styles = HTMLAttributes.applyStyles(["display: flex", "flex-direction: column"])
	}
}
