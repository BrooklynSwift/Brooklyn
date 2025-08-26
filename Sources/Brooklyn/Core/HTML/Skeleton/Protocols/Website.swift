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
	
	func render(from: StaticString, includesBaseStyles: Bool)
}

public extension Website {
	@MainActor
	func render(from file: StaticString = #filePath, includesBaseStyles: Bool = true) {
		WebsiteManager.configure(file: file)
		
		guard let homePage = pages.first else { return }
		homePage.render(from: file, configuration: homePage.configuration, includesBaseStyles: includesBaseStyles)
		
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
			
			$0.render(
				from: file,
				writeTo: "\(pageName).html",
				configuration: $0.configuration,
				includesBaseStyles: includesBaseStyles
			)
		}
	}
}
