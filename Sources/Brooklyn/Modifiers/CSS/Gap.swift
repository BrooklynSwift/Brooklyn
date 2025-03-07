//
//  Gap.swift
//
//
//  Created by Luki on 13/10/2024.
//

import Foundation

public extension Stylable {
	func gap(_ value: CSSDimension) -> Self {
		style("gap: \(value.rawValue)")
	}
}
