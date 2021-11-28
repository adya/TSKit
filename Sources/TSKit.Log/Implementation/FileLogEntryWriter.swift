// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md

import Foundation
import TSKit_Core

public class FileLogEntryWriter: AnyLogEntryWriter {

    public var interceptors: [AnyLogInterceptor]

    public var decorator: AnyLogEntryDecorator

    public let logFile: URL

    private let fileHandle: FileHandle

    public init?(logFile: URL,
                 decorator: AnyLogEntryDecorator = LogEntryDecorator(),
                 interceptors: AnyLogInterceptor...) {
        self.logFile = logFile
        self.decorator = decorator
        self.interceptors = interceptors
        do {
            try? FileManager.default.createDirectory(at: logFile.deletingLastPathComponent(),
                                                     withIntermediateDirectories: true,
                                                     attributes: nil)
            if !FileManager.default.fileExists(atPath: logFile.path) {
                FileManager.default.createFile(atPath: logFile.path, contents: nil)
            }
            fileHandle = try FileHandle(forWritingTo: logFile)
            try tryWithException {
                self.fileHandle.seekToEndOfFile()
            }
        } catch {
            print("Failed to open file handler with error: \(error)")
            return nil
        }
    }

    deinit {
        fileHandle.closeFile()
    }

    public func write(_ entry: LogEntry) {
        if let message = (decorator.decorate(entry) ==> {"\n\($0)"}).data(using: .utf8) {
            if #available(iOS 13.4, macOS 10.15.4, *) {
                try? fileHandle.write(contentsOf: message)
            } else {
                try? tryWithException {
                    self.fileHandle.write(message)
                }
            }
        } else {
            print("Failed to write entry \(entry).")
        }
    }
}
