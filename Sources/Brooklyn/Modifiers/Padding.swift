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

	func paddingTop(_ length: CSSDimension = .px(20)) -> Self {
		self.style("padding-top: \(length.rawValue)")
	}

	func paddingRight(_ length: CSSDimension = .px(20)) -> Self {
		self.style("padding-right: \(length.rawValue)")
	}

	func paddingBottom(_ length: CSSDimension = .px(20)) -> Self {
		self.style("padding-bottom: \(length.rawValue)")
	}

	func paddingLeft(_ length: CSSDimension = .px(20)) -> Self {
		self.style("padding-left: \(length.rawValue)")
	}
}
