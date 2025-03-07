//
//  Background.swift
//
//
//  Created by Luki on 07/10/2024.
//

import Foundation

public extension Stylable {
	func background(_ color: CSSColor) -> Self {
		self.style("background-color: \(color.rawValue)")
	}

	func background(_ color: String) -> Self {
		self.style("background-color: \(color)")
	}
}
