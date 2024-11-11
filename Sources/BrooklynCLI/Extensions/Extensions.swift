//
//  Extensions.swift
//
//
//  Created by Luki on 04/11/2024.
//

import class Foundation.Pipe
import class Foundation.Process

extension Process {
	@discardableResult
	static func execute(command: String, then nextCommand: String = "") -> String {
		let process = Process()
		process.arguments = ["-c", command]
		process.executableURL = .init(filePath: "/bin/zsh")

		let pipe = Pipe()
		process.standardOutput = pipe

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

		do {
			let data = pipe.fileHandleForReading.readDataToEndOfFile()
			return String(decoding: data, as: UTF8.self)
		}
	}
}
