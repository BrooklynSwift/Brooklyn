//
//  BrooklynCLI.swift
//
//
//  Created by Luki on 13/10/2024.
//

import ArgumentParser
import Foundation

private let fileWatcher = FileWatcher(paths: [FileManager.default.currentDirectoryPath + "/Sources/"])

@main
private struct BrooklynCLI: AsyncParsableCommand {
	@Flag
	var force = false

	@Flag
	var watch = false

	func run() async throws {
		if watch {
			watchFiles()
		}

		if force {
			let pid = getRunningServerPID()
			Process.execute(command: "kill \(pid)")
		}

		Process.execute(command: "swift run")
		Process.execute(command: "python3 -m http.server -d Build/ 1337")
	}

	private func watchFiles() {
		let appleScript = """
		tell application "Safari"
			set currentTab to current tab of front window
			set URL of currentTab to (URL of currentTab)
		end tell
		"""

		fileWatcher.callback = {
			Process.execute(command: "swift run")

			guard let script = NSAppleScript(source: appleScript) else { return }
			script.executeAndReturnError(nil)
		}
		fileWatcher.start()
	}

	private func getRunningServerPID() -> String {
		let result = Process.execute(command: "lsof -t -i tcp:1337")
		return result
	}
}
