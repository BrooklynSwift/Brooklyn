//
//  File.swift
//  
//
//  Created by Luki on 27/10/2024.
//

import Foundation

@frozen
public enum DisplayOptions: String {
	case block, flex, grid
}

public extension Stylable {
	func display(_ value: DisplayOptions) -> Self {
		style("display: \(value.rawValue)")
	}
}
