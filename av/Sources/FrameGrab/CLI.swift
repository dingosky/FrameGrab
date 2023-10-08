import AppKit
import ArgumentParser

@available(macOS 13, *)
@main
struct CLI: ParsableCommand, AsyncParsableCommand {
  @Option(name: .shortAndLong, help: "Number of milli snaps")
  var snaps: Int = 1

  @Option(name: .shortAndLong, help: "Output images path")
  var out: String = ""
  
  @Argument(help: "Input video file path")
  var videoFile: String
  
  @Argument(help: "Snap time (in millis)")
  var startMillis: Int

  mutating func run() async throws {
    let cwd = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)

    let videoURL = URL(fileURLWithPath: videoFile, relativeTo: cwd)
    let outPathURL = URL(fileURLWithPath: out, relativeTo: cwd)    
    
    do {
      let snapGrabber = try SnapGrabber(videoURL: videoURL, outPathURL: outPathURL)
      try await snapGrabber.snap(start: startMillis, count: snaps)
    } catch {
      CLI.exit(withError: error)
    }
    print("...done")
  }
}
