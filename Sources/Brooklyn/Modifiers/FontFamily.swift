//
//  FontFamily.swift
//  
//
//  Created by Luki on 10/10/2024.
//

import Foundation

public extension Stylable {
	func fontFamily(_ family: CSSFontFace.FontFamily) -> Self {
		style("font-family: \(family.name)")
	}
}
