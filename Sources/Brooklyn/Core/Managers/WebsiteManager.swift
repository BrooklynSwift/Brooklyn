//
//  WebsiteManager.swift
//
//
//  Created by Luki on 09/10/2024.
//

import Foundation

@MainActor
internal
final class WebsiteManager {
	private
	static var instance: WebsiteManager?

	static var shared: WebsiteManager {
		guard let instance else { fatalError("WebsiteManager.shared accessed before calling configure(file:)") }
		return instance
	}

	static func configure(file: StaticString) {
		guard instance == nil else { return }
		instance = WebsiteManager(file: file)
		instance?.cleanBuildDirectory()
		instance?.copyAssets()
	}

	// MARK: - Private

	private let assetsDirectory, buildDirectory: URL

	private init(file: StaticString) {
		let rootDir: URL = .findProjectRoot(from: file)
		assetsDirectory = rootDir.appending(path: "Assets/")
		buildDirectory = rootDir.appending(path: "Build/")
	}

	private func cleanBuildDirectory() {
		do {
			try FileManager.default.removeItem(at: buildDirectory)
			try FileManager.default.createDirectory(at: buildDirectory, withIntermediateDirectories: true)
		}
		catch {
			print(error.localizedDescription)
		}
	}

	private func copyAssets() {
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
