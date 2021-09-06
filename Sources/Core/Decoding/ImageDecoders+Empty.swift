// The MIT License (MIT)
//
// Copyright (c) 2015-2021 Alexander Grebenyuk (github.com/kean).

#if !os(macOS)
import UIKit
#else
import Cocoa
#endif

#if os(watchOS)
import WatchKit
#endif

extension ImageDecoders {
    /// A decoder that returns an empty placeholder image and attaches image
    /// data to the image container.
    public struct Empty: ImageDecoding {
        public let isProgressive: Bool
        private let imageType: ImageType?

        public var isAsynchronous: Bool {
            false
        }

        /// Initializes the decoder.
        ///
        /// - Parameters:
        ///   - type: Image type to be associated with an image container.
        ///   `nil` by defalt.
        ///   - isProgressive: If `false`, returns nil for every progressive
        ///   scan. `false` by default.
        public init(imageType: ImageType? = nil, isProgressive: Bool = false) {
            self.imageType = imageType
            self.isProgressive = isProgressive
        }

        public func decodePartiallyDownloadedData(_ data: Data) -> ImageContainer? {
            isProgressive ? ImageContainer(image: PlatformImage(), type: imageType, data: data, userInfo: [:]) : nil
        }

        public func decode(_ data: Data) -> ImageContainer? {
            ImageContainer(image: PlatformImage(), type: imageType, data: data, userInfo: [:])
        }
    }
}
