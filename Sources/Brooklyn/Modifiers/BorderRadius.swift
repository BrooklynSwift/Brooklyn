//
//  BorderRadius.swift
//
//
//  Created by Luki on 07/10/2024.
//

import Foundation

public extension Stylable {
	func borderRadius(_ value: CSSDimension) -> Self {
		self.style("border-radius: \(value.rawValue)")
	}
}
