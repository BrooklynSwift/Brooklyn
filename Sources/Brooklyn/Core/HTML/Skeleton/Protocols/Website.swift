//
//  Website.swift
//
//
//  Created by Luki on 17/10/2024.
//

import Foundation

/// A protocol that describes a Brooklyn website
@MainActor
public protocol Website {
	@PageBuilder
	var pages: [PageContent] { get }

	func render(includesBaseStyles: Bool)
}

public extension Website {
	@MainActor
	func render(includesBaseStyles: Bool = true) {
		WebsiteManager.shared.cleanBuildDirectory()
		WebsiteManager.shared.copyAssets()

		guard let homePage = pages.first else { return }
		homePage.render(configuration: homePage.configuration, includesBaseStyles: includesBaseStyles)

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

			$0.render(configuration: $0.configuration, filePath: "\(pageName).html", includesBaseStyles: includesBaseStyles)
		}
	}
}
