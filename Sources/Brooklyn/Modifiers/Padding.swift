//
//  Padding.swift
//
//
//  Created by Luki on 10/10/2024.
//

import Foundation

public extension Stylable {
	func padding(_ length: CSSDimension = .px(20)) -> Self {
		self.style("padding: \(length.rawValue)")
	}
}
