//
//  Frame.swift
//
//
//  Created by Luki on 07/10/2024.
//

import Foundation

public extension Stylable {
	func frame(
		width: CSSDimension? = nil,
		minWidth: CSSDimension? = nil,
		maxWidth: CSSDimension? = nil,
		height: CSSDimension? = nil,
		minHeight: CSSDimension? = nil,
		maxHeight: CSSDimension? = nil
	) -> Self {
		var copy = self

		let styles = [
			width.map { "width: \($0.rawValue)" },
			minWidth.map { "min-width: \($0.rawValue)" },
			maxWidth.map { "max-width: \($0.rawValue)" },
			height.map { "height: \($0.rawValue)" },
			minHeight.map { "min-height: \($0.rawValue)" },
			maxHeight.map { "max-height: \($0.rawValue)" }
		].compactMap { $0 }

		styles.forEach { copy = copy.style($0) }
		return copy
	}
}
