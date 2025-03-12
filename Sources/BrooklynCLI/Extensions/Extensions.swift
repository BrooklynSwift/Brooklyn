//
//  Extensions.swift
//
//
//  Created by Luki on 04/11/2024.
//

import Foundation

extension Process {
	@discardableResult
	static func execute(command: String, then nextCommand: String = "") -> String {
		let process = Process()
		process.arguments = ["-c", command]
		process.executableURL = .init(filePath: "/bin/zsh")

		// TODO: process both stdout & stderr at the same time without blocking
		let output = Pipe()
		process.standardOutput = output

		Task {
			try process.run()
		}

		if !nextCommand.isEmpty {
			Task {
				try await Task.sleep(for: .seconds(1))
				return Process.execute(command: nextCommand)
			}
			_ = readLine()
			process.terminate()
		}

		return String(decoding: output.fileHandleForReading.readDataToEndOfFile(), as: UTF8.self)
	}
}
