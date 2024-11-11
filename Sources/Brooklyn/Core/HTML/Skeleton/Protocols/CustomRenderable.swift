//
//  CustomRenderable.swift
//
//
//  Created by Luki on 13/10/2024.
//

import Foundation

/// A protocol that describes a custom element composed by pre existing HTML elements
internal protocol CustomRenderable: HTMLRenderable {
	@HTMLBuilder
	var body: [HTMLRenderable] { get }
}

extension CustomRenderable {
	public func render(indent: String) -> String {
		body.map { $0.render(indent: indent) }.joined()
	}
}
