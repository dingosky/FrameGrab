
enum FrameGrabError: Error {
  case dirDNE
  case notDirUrl
  case notReachable
  case notWritable
  case malformedUrl
  case pngRepresentation

  
  public var localizedDescription: String {
    switch self {
      case .dirDNE:
        return "Image location does not exist"
      case .notDirUrl:
        return "Image location not a directory"
      case .notReachable:
        return "Video not reachable"
      case .notWritable:
        return "Image location not writable"
      case .malformedUrl:
        return "Image location is malformed URL"
      case .pngRepresentation:
        return "Failed representing image as PNG"
    }
  }
}
