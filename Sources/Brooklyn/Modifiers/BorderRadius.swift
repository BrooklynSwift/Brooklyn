//
//  File.swift
//  
//
//  Created by Luki on 07/10/2024.
//

import Foundation

public extension HTMLCoreRenderable {
	func borderRadius(_ value: CSSDimension) -> Self {
		self.style("border-radius: \(value.rawValue)")
	}
}
