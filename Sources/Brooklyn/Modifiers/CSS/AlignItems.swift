//
//  AlignItems.swift
//  
//
//  Created by Luki on 13/10/2024.
//

import Foundation

@frozen
public enum Edge: String {
	case top, bottom, leading, trailing, center
}

public extension Stylable {
	func alignItems(_ edge: Edge) -> Self {
		style("align-items: \(edge.rawValue)")
	}
}
