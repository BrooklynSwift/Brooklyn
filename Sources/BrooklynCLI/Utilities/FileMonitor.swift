//
//  FileWatcher.swift
//
//
//  Created by Luki on 04/11/2024.
//

import Foundation

internal
final class FileMonitor: @unchecked Sendable {
	static let shared = FileMonitor()
	private init() {}

	private let eventCallback: FSEventStreamCallback = { _, contextInfo, numEvents, eventPaths, _, _ in
		guard let contextInfo else { return }

		let fileMonitor = Unmanaged<FileMonitor>.fromOpaque(contextInfo).takeUnretainedValue()
		let paths = Unmanaged<CFArray>.fromOpaque(eventPaths).takeUnretainedValue() as? [String] ?? []

		fileMonitor.onFileMonitor()
	}

	private var paths = [FileManager.default.currentDirectoryPath + "/Sources/"]
	private var streamRef: FSEventStreamRef?

	var onFileMonitor: () -> Void = {}

	/// Function to start monitoring for event changes
	func startMonitoring() {
		guard streamRef == nil else { return }

		var context = FSEventStreamContext(
			version: 0,
			info: Unmanaged.passUnretained(self).toOpaque(),
			retain: nil,
			release: nil,
			copyDescription: nil
		)

		streamRef = FSEventStreamCreate(
			kCFAllocatorDefault,
			eventCallback,
			&context,
			paths as CFArray,
			FSEventStreamEventId(kFSEventStreamEventIdSinceNow),
			0,
			UInt32(kFSEventStreamCreateFlagUseCFTypes | kFSEventStreamCreateFlagFileEvents)
		)

		FSEventStreamSetDispatchQueue(streamRef!, .main)
		FSEventStreamStart(streamRef!)
	}
}
