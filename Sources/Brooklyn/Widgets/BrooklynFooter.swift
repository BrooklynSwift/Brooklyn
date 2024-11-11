//
//  BrooklynFooter.swift
//
//
//  Created by Luki on 15/10/2024.
//

import Foundation

/// A struct that represents a Brooklyn footer, which will display a label with a link to the project's GitHub
public struct BrooklynFooter: CustomRenderable {
	public var attributes: HTMLAttributes = .init()

	internal var body: [HTMLRenderable] {
		var span = Span {
			Text("Made with")
			Link("Brooklyn", target: "https://github.com/Luki120/Brooklyn/")
				.class("brooklyn-text")
		}

		span.attributes = attributes
		span.attributes.class = "brooklyn-footer"
		return [span]
	}

	public init() {}
}
