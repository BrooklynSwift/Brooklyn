//
//  Border.swift
//
//
//  Created by Luki on 07/10/2024.
//

import Foundation

public extension Stylable {
	func border(_ value: Int) -> Self {
		self.style("border: \(value)")
	}
}
