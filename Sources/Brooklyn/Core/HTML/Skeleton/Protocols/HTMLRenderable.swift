//
//  HTMLRenderable.swift
//
//
//  Created by Luki on 04/10/2024.
//

import Foundation

// MARK: - Public

/// A protocol that describes an element that can be rendered into an HTML string
public protocol HTMLRenderable: Stylable {
	func render(indent: String) -> String
}
