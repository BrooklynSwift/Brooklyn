//
//  FlexDirection.swift
//
//
//  Created by Luki on 27/10/2024.
//

import Foundation

@frozen
public enum FlexDirection: String {
	case column, row
}

public extension Stylable {
	func flexDirection(_ direction: FlexDirection) -> Self {
		style("flex-direction: \(direction.rawValue)")
	}
}
