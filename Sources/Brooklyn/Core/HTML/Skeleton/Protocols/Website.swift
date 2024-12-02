//
//  Site.swift
//
//
//  Created by Luki on 17/10/2024.
//

import Foundation

/// A protocol that describes a Brooklyn website
public protocol Website {
	@PageBuilder
	var pages: [PageContent] { get }

	func render()
}

public extension Website {
	func render() {
		WebsiteManager.shared.cleanBuildDirectory()
		WebsiteManager.shared.copyAssets()

		guard let homePage = pages.first else { return }
		homePage.render(withConfiguration: homePage.configuration)

		pages.dropFirst().forEach {
			let pageName = String(describing: type(of: $0))
				.enumerated()
				.map { index, char in
					if index > 0 && char.isUppercase {
						return "-\(char)"
					}
					return String(char)
				}
				.joined()
				.lowercased()

			$0.render(withConfiguration: $0.configuration, filePath: "\(pageName).html")
		}
	}
}
