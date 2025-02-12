//
//  HTMLCoreRenderable.swift
//
//
//  Created by Luki on 16/10/2024.
//

import Foundation

/// A protocol that describes an existing HTML element, such as `div` e.g., which can be rendered into an HTML string
public protocol HTMLCoreRenderable: HTMLRenderable, Stylable {
	var tag: String { get }
	var children: [HTMLRenderable] { get }
}

public extension HTMLCoreRenderable {
	func render(indent: String = .fourSpaces) -> String {
		let childrenString = children.map { $0.render(indent: indent + .fourSpaces) }.joined()
		return "\(indent)<\(tag)\(attributes())>\n\(childrenString)\(indent)</\(tag)>\n"
	}
}
