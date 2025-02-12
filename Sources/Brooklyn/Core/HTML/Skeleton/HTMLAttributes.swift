//
//  HTMLAttributes.swift
//
//
//  Created by Luki on 04/10/2024.
//

import Foundation

/// A struct that represents HTML attributes a website should support
public struct HTMLAttributes {
	internal var ariaLabel = ""
	internal var `class` = ""
	internal var href = ""
	internal var id = ""
	internal var onClick = ""
	internal var styles = [String]()

	internal
	static func applyStyles(_ styles: [String]) -> [String] {
		return styles.compactMap { value in
			let parts = value.split(separator: ":")
			guard parts.count == 2 else { return nil }
			return "\(parts[0]):\(parts[1]);"
		}
	}
}
