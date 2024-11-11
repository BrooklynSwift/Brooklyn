//
//  Title.swift
//
//
//  Created by Luki on 13/10/2024.
//

import Foundation

/// A struct that provides syntatic sugar to represent an HTML heading
public struct Title: CustomRenderable {
	public var attributes: HTMLAttributes = .init()
	internal let children: () -> [HTMLRenderable]

	internal var body: [HTMLRenderable] {
		var h1 = H1(children)
		h1.attributes = attributes
		return [h1]
	}

	/// Designated initializer
	/// - Parameters:
	/// 	- children: Escaping closure that takes no arguments & returns an array of `HTMLRenderable`, which represents the children for this object
	public init(@HTMLBuilder children: @escaping () -> [HTMLRenderable]) {
		self.children = children
	}
}
