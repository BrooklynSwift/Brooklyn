//
//  Extensions.swift
//
//
//  Created by Luki on 09/10/2024.
//

import Foundation

public extension String {
	internal func write(toFile file: String, from filePath: StaticString) {
		let rootDir: URL = .findProjectRoot(from: filePath)
		let buildDir = rootDir.appending(path: "Build/")
		
		var isDirectory: ObjCBool = true
		
		let dirExists = FileManager.default.fileExists(atPath: buildDir.path(), isDirectory: &isDirectory)
		if !dirExists {
			try? FileManager.default.createDirectory(at: buildDir, withIntermediateDirectories: true)
		}
		try? self.write(to: buildDir.appending(path: file), atomically: true, encoding: .utf8)
	}
	
	static var fourSpaces: String {
		return "    "
	}
	
	internal
	static var separator: String {
		return "\n" + String.fourSpaces
	}
}

internal extension URL {
	static func findProjectRoot(from file: StaticString) -> URL {
		var currentURL = URL(filePath: file.description)
		
		repeat {
			if FileManager.default.fileExists(atPath: currentURL.appending(path: "Package.swift").path) {
				return currentURL
			}
			currentURL.deleteLastPathComponent()
		} while currentURL.path != "/"
		
		return .init(filePath: "")	
	}
}
