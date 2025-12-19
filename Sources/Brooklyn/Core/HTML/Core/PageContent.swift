//
//  PageContent.swift
//  
//
//  Created by Luki on 03/10/2024.
//

import Foundation

/// A protocol that describes the content of an HTML page
@MainActor
public protocol PageContent {
	@HTMLBuilder
	var body: [HTMLRenderable] { get }

	var configuration: PageConfiguration { get }

	func render(from: StaticString, writeTo: String, configuration: PageConfiguration, includesBaseStyles: Bool)
}

public extension PageContent {
	func render(
		from file: StaticString,
		writeTo filePath: String = "index.html",
		configuration: PageConfiguration = .init(),
		includesBaseStyles: Bool
	) {
		let newLine = configuration.stylesheet != nil ? "\(String.separator)" : ""
		let stylesheet = "<link rel=\"stylesheet\" type=\"text/css\" href=\"\(configuration.stylesheet?.name ?? "")\">\(String.separator)"
		let baseStylesheet = "<link rel=\"stylesheet\" type=\"text/css\" href=\"base.css\">\(String.separator)"

		var html = """
		<!DOCTYPE html>
		<html lang="en">
		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">\(newLine)
		"""

		if configuration.stylesheet != nil {
			html.append(stylesheet)
		}

		if includesBaseStyles {
			html.append(baseStylesheet)
		}

		html.append("""
		<title>\(configuration.title)</title>
		</head>
		<body>
		\(body.map { $0.render(indent: .fourSpaces) }.joined())
		</body>
		</html>
		""")

		html.write(toFile: filePath, from: file)

		guard let stylesheet = configuration.stylesheet else { return }
		stylesheet.render(from: file)

		guard includesBaseStyles else { return }

		let baseStyles = BaseStyles()
		baseStyles.render(from: file)
	}
}

/// A struct that represents a page's configuration
public struct PageConfiguration {
	fileprivate let favIcon: String
	fileprivate let title: String
	fileprivate let stylesheet: Stylesheet?

	/// Designated initiaizer
	/// - Parameters:
	///		- favIcon: A `String` that represents the page's fav icon
	///		- title: A `String` that represents the page's title
	///		- stylesheet: A `Stylesheet` object that represents the css for the current page
	public init(favIcon: String = "", title: String = "", stylesheet: Stylesheet? = nil) {
		self.favIcon = favIcon
		self.title = title
		self.stylesheet = stylesheet
	}
}

@MainActor
private struct BaseStyles: @MainActor Stylesheet {
	let name = "base.css"

	@MainActor
	private struct Base: @MainActor CSSClass {
		let name = "body"

		var rules: [CSSRule] {
			CSSRule(selector: name) {
				CSSProperty(name: .backgroundColor, value: "light-dark(white, black)")
				CSSProperty(name: .fontFamily, value: "arial")
			}
		}
	}

	@MainActor
	private struct Resets: @MainActor CSSClass {
		let name = "html, body"

		var rules: [CSSRule] {
			CSSRule(selector: name) {
				CSSProperty(name: .margin, value: "0")
				CSSProperty(name: .padding, value: "0")
			}
		}
	}

	var classes: [CSSClass] {
		Base()
		Resets()
	}

	var variables: [CSSVariable] {
		CSSVariable(name: "color-scheme", value: "light dark")
	}
}
