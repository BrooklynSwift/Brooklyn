//
//  WebsiteManager.swift
//
//
//  Created by Luki on 09/10/2024.
//

import Foundation

internal
final class WebsiteManager {
	static let shared = WebsiteManager()

	private var assetsDirectory: URL!
	private var buildDirectory: URL!
	private var rootDirectory: URL = .init(fileURLWithPath: FileManager.default.currentDirectoryPath).deletingLastPathComponent()

	//  MARK: - Private

	private init() {
		assetsDirectory = createDirectory(withName: "Assets/")
		buildDirectory = createDirectory(withName: "Build/")
	}

	private func createDirectory(withName path: String) -> URL {
		let rootDirectory = rootDirectory.findProjectRoot(startingAt: rootDirectory)
		return rootDirectory.appending(path: path)
	}
}

// MARK: - Internal

internal extension WebsiteManager {
	func cleanBuildDirectory() {
		do {
			try FileManager.default.removeItem(at: buildDirectory)
			try FileManager.default.createDirectory(at: buildDirectory, withIntermediateDirectories: true)
		}
		catch {
			print(error.localizedDescription)
		}
	}

	func copyAssets() {
		do {
			let assets = try FileManager.default.contentsOfDirectory(at: assetsDirectory, includingPropertiesForKeys: nil)
			try assets.forEach {
				try FileManager.default.copyItem(
					at: assetsDirectory.appending(path: $0.lastPathComponent),
					to: buildDirectory.appending(path: $0.lastPathComponent)
				)
			}
		}
		catch {
			print(error.localizedDescription)
		}
	}
}
