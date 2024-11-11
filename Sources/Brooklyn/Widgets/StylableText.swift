//
//  StylableText.swift
//
//
//  Created by Luki on 16/10/2024.
//

import Foundation

/// A struct that represents a piece of text wrapped in a `Span` so that it can be customized
public struct StylableText: CustomRenderable, TextRenderable {
	public var attributes: HTMLAttributes = .init()
	internal let children: () -> [any TextRenderable]

	internal var body: [HTMLRenderable] {
		var span = Span(children)
		span.attributes = attributes
		return [span]
	}

	/// Designated initializer
	/// - Parameter children: Escaping closure that takes no arguments & returns an array of`any TextRenderable`
	public init(@GenericBuilder<any TextRenderable> children: @escaping () -> [any TextRenderable]) {
		self.children = children
	}
}

/// A protocol that describes text that can be rendered into an HTML string
public protocol TextRenderable: HTMLRenderable {}
extension Text: TextRenderable {}
