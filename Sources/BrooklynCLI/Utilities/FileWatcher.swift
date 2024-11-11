//
//  FileWatcher.swift
//
//
//  Created by Luki on 04/11/2024.
//

import Foundation

internal class FileWatcher {
	private let eventCallback: FSEventStreamCallback = { _, contextInfo, numEvents, eventPaths, _, _ in
		guard let contextInfo else { return }

		let watcher = Unmanaged<FileWatcher>.fromOpaque(contextInfo).takeUnretainedValue()
		let paths = Unmanaged<CFArray>.fromOpaque(eventPaths).takeUnretainedValue() as? [String] ?? []

		watcher.callback?()
	}

	private var streamRef: FSEventStreamRef?

	var callback: (() -> Void)?

	private let paths: [String]

	/// Designated initializer
	/// - Parameter paths: An array of strings that represent the paths to watch
	init(paths: [String]) {
		self.paths = paths
	}

	/// Function to start watching for event changes
	func start() {
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
