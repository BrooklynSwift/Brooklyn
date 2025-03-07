//
//  FontSize.swift
//
//
//  Created by Luki on 10/10/2024.
//

import Foundation

public extension Stylable {
	func fontSize(_ dimension: CSSDimension) -> Self {
		style("font-size: \(dimension.rawValue)")
	}
}
