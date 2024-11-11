//
//  PageContent.swift
//  
//
//  Created by Luki on 03/10/2024.
//

import Foundation

/// A protocol that describes the content of an HTML page
public protocol PageContent {
	@HTMLBuilder
	var body: [HTMLRenderable] { get }

	var configuration: PageConfiguration { get }

	func render(withConfiguration config: PageConfiguration, filePath: String)
}

public extension PageContent {
	func render(withConfiguration config: PageConfiguration = .init(), filePath: String = "index.html") {
		let newLine = config.stylesheet != nil ? "\(String.separator)" : ""
		let stylesheet = "<link rel=\"stylesheet\" type=\"text/css\" href=\"\(config.stylesheet?.name() ?? "")\">\(String.separator)"

		var html = """
		<!DOCTYPE html>
		<html lang="en">
		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">\(newLine)
		"""

		if config.stylesheet != nil {
			html.append(stylesheet)
		}

		html.append("""
		<title>\(config.title)</title>
		</head>
		<body>
		\(body.map { $0.render(indent: .fourSpaces) }.joined())
		</body>
		</html>
		""")

		html.write(toFile: filePath)

		guard let stylesheet = config.stylesheet else { return }
		stylesheet.render()
	}
}

/// A struct that represents a page's configuration
public struct PageConfiguration {
	fileprivate var favIcon = ""
	fileprivate var title = ""
	fileprivate var stylesheet: Stylesheet? = nil

	/// Designated initiaizer
	/// - Parameters:
	///		- favIcon: A string that represents the page's fav icon
	///		- title: A string that represents the page's title
	///		- stylesheet: A `Stylesheet` object that represents the css for the current page
	public init(favIcon: String = "", title: String = "", stylesheet: Stylesheet? = nil) {
		self.favIcon = favIcon
		self.title = title
		self.stylesheet = stylesheet
	}
}
