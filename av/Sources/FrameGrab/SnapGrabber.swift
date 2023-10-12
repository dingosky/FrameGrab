import AVFoundation

//@available(macOS 10.15.0, *)
@available(macOS 13, *)
struct SnapGrabber {
  let imageGenerator: AVAssetImageGenerator
  let outPathURL: URL

  init(videoURL: URL, outPathURL: URL) throws {
    print("  input video:", videoURL.absoluteString)
    guard try videoURL.checkResourceIsReachable() else {
      throw FrameGrabError.notReachable
    }
    
    print("  images path:", outPathURL.absoluteString)

    var isDir: ObjCBool = false
    guard FileManager.default.fileExists(atPath: outPathURL.path, isDirectory: &isDir) else {
      throw FrameGrabError.dirDNE
    }
    guard isDir.boolValue else {
      throw FrameGrabError.notDirUrl
    }
    let videoAsset = AVURLAsset(url: videoURL)
    
    let imageGenerator = AVAssetImageGenerator(asset: videoAsset)
    imageGenerator.requestedTimeToleranceAfter = CMTime.zero
    imageGenerator.requestedTimeToleranceBefore = CMTime.zero
    
    self.imageGenerator = imageGenerator
    self.outPathURL = outPathURL
  }
  
  var videoAsset: AVURLAsset {
    imageGenerator.asset as! AVURLAsset
  }
  
  var videoURL: URL {
    videoAsset.url
  }
  
  func snapName(_ snapMillis: Int64) -> String {
    let videoName = videoURL.deletingPathExtension().lastPathComponent
    return "av_\(videoName)_\(snapMillis)_.png"
  }
  
//  @available(macOS 13, *)
  func snap(start millis: Int, count snaps: Int) async throws {
    for snap in 0..<snaps {
      let snapMillis = CMTimeValue(millis + snap)
      let pngName = snapName(snapMillis)
      print("    --> ", pngName)

      let snapTime = CMTimeMake(value: snapMillis, timescale: 1_000)
      let fileURL = URL(fileURLWithPath: pngName, relativeTo: outPathURL)

      let (cgImage, _) = try await imageGenerator.image(at: snapTime)
      if let error = cgImage.writePng(to: fileURL.path) {
        throw error
      }
    }
  }

}
