//
//  FlexGrow.swift
//
//
//  Created by Luki on 13/10/2024.
//

import Foundation

public extension Stylable {
	func flexGrow(_ value: Int) -> Self {
		style("flex-grow: \(value)")
	}
}
