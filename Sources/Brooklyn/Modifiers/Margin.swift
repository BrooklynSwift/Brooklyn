//
//  Margin.swift
//  Brooklyn
//
//  Created by Luki on 12/02/2025.
//

import Foundation

public extension Stylable {
	func margin(_ length: CSSDimension = .px(20)) -> Self {
		self.style("margin: \(length.rawValue)")
	}

	func marginTop(_ length: CSSDimension = .px(20)) -> Self {
		self.style("margin-top: \(length.rawValue)")
	}

	func marginRight(_ length: CSSDimension = .px(20)) -> Self {
		self.style("margin-right: \(length.rawValue)")
	}

	func marginBottom(_ length: CSSDimension = .px(20)) -> Self {
		self.style("margin-bottom: \(length.rawValue)")
	}

	func marginLeft(_ length: CSSDimension = .px(20)) -> Self {
		self.style("margin-left: \(length.rawValue)")
	}
}
