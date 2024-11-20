//
//  HTMLBuilder.swift
//
//
//  Created by Luki on 04/10/2024.
//

internal typealias HTMLBuilder = GenericBuilder<HTMLRenderable>
internal typealias ButtonBuilder = GenericBuilder<ButtonContent>
internal typealias PageBuilder = GenericBuilder<PageContent>

/// A result builder struct useful for creating custom reusable HTML components
@resultBuilder
public struct HTMLWidgetBuilder {
	public
	static func buildBlock(_ children: HTMLRenderable...) -> HTMLComponent {
		return HTMLComponent(children: children)
	}
}

/// A result builder struct to create generic builders of some type of HTML content
@resultBuilder
public struct GenericBuilder<T> {
	public
	static func buildBlock(_ components: T...) -> [T] {
		return components
	}

	public
	static func buildExpression(_ expression: T) -> T {
		return expression
	}

	public
	static func buildExpression(_ expression: String) -> T where T == HTMLRenderable {
		return Text(expression)
	}

	public
	static func buildExpression(_ expression: String) -> T where T == ButtonContent {
		return Text(expression)
	}
}
