//
//  ForegroundStyle.swift
//
//
//  Created by Luki on 07/10/2024.
//

import Foundation

public extension Stylable {
	func foregroundStyle(_ color: String) -> Self {
		self.style("color: \(color)")
	}

	func foregroundStyle(_ color: CSSColor) -> Self {
		self.style("color: \(color.rawValue)")
	}
}
