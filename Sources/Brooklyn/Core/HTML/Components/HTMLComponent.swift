//
//  HTMLComponent.swift
//
//
//  Created by Luki on 27/10/2024.
//

import Foundation

/// A struct that represents an HTML component
public struct HTMLComponent: HTMLRenderable {
	let children: [HTMLRenderable]

	public var attributes: HTMLAttributes = .init()

	public func render(indent: String) -> String {
		children.reduce(into: "") {
			$0 += $1.render(indent: indent)
		}
	}
}
