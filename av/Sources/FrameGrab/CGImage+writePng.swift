import AppKit

extension CGImage {
  func writePng(to destination: String) -> Error? {
    let nsImage = NSImage(cgImage: self, size: .zero)
    return nsImage.writePng(to: destination)
  }
}

extension NSImage {
  var pngData: Data? {
    guard let tiff = tiffRepresentation,
          let bitmapImage = NSBitmapImageRep(data: tiff) else { return nil }
    return bitmapImage.representation(using: .png, properties: [:])
  }
  
  func writePng(to destination: String) -> Error? {
    do {
      let fileUrl = URL(fileURLWithPath: destination)

      let dirPath = fileUrl.deletingLastPathComponent().path
      guard FileManager.default.isWritableFile(atPath: dirPath) else {
        return FrameGrabError.notWritable
      }
      
      guard let data = pngData else {
        return FrameGrabError.pngRepresentation
      }

      try data.write(to: fileUrl)
      
      return nil
    } catch {
      return error
    }
  }
}
