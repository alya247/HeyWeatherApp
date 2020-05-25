// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let launchBackground = ImageAsset(name: "launch_background")
  internal static let a01d = ImageAsset(name: "a01d")
  internal static let a01n = ImageAsset(name: "a01n")
  internal static let a02d = ImageAsset(name: "a02d")
  internal static let a02n = ImageAsset(name: "a02n")
  internal static let a03d = ImageAsset(name: "a03d")
  internal static let a03n = ImageAsset(name: "a03n")
  internal static let a04d = ImageAsset(name: "a04d")
  internal static let a04n = ImageAsset(name: "a04n")
  internal static let a05d = ImageAsset(name: "a05d")
  internal static let a05n = ImageAsset(name: "a05n")
  internal static let a06d = ImageAsset(name: "a06d")
  internal static let a06n = ImageAsset(name: "a06n")
  internal static let c01d = ImageAsset(name: "c01d")
  internal static let c01n = ImageAsset(name: "c01n")
  internal static let c02d = ImageAsset(name: "c02d")
  internal static let c02n = ImageAsset(name: "c02n")
  internal static let c03d = ImageAsset(name: "c03d")
  internal static let c03n = ImageAsset(name: "c03n")
  internal static let c04d = ImageAsset(name: "c04d")
  internal static let c04n = ImageAsset(name: "c04n")
  internal static let d01d = ImageAsset(name: "d01d")
  internal static let d01n = ImageAsset(name: "d01n")
  internal static let d02d = ImageAsset(name: "d02d")
  internal static let d02n = ImageAsset(name: "d02n")
  internal static let d03d = ImageAsset(name: "d03d")
  internal static let d03n = ImageAsset(name: "d03n")
  internal static let f01d = ImageAsset(name: "f01d")
  internal static let f01n = ImageAsset(name: "f01n")
  internal static let r01d = ImageAsset(name: "r01d")
  internal static let r01n = ImageAsset(name: "r01n")
  internal static let r02d = ImageAsset(name: "r02d")
  internal static let r02n = ImageAsset(name: "r02n")
  internal static let r03d = ImageAsset(name: "r03d")
  internal static let r03n = ImageAsset(name: "r03n")
  internal static let r04d = ImageAsset(name: "r04d")
  internal static let r04n = ImageAsset(name: "r04n")
  internal static let r05d = ImageAsset(name: "r05d")
  internal static let r05n = ImageAsset(name: "r05n")
  internal static let r06d = ImageAsset(name: "r06d")
  internal static let r06n = ImageAsset(name: "r06n")
  internal static let s01d = ImageAsset(name: "s01d")
  internal static let s01n = ImageAsset(name: "s01n")
  internal static let s02d = ImageAsset(name: "s02d")
  internal static let s02n = ImageAsset(name: "s02n")
  internal static let s03d = ImageAsset(name: "s03d")
  internal static let s03n = ImageAsset(name: "s03n")
  internal static let s04d = ImageAsset(name: "s04d")
  internal static let s04n = ImageAsset(name: "s04n")
  internal static let s05d = ImageAsset(name: "s05d")
  internal static let s05n = ImageAsset(name: "s05n")
  internal static let s06d = ImageAsset(name: "s06d")
  internal static let s06n = ImageAsset(name: "s06n")
  internal static let t01d = ImageAsset(name: "t01d")
  internal static let t01n = ImageAsset(name: "t01n")
  internal static let t02d = ImageAsset(name: "t02d")
  internal static let t02n = ImageAsset(name: "t02n")
  internal static let t03d = ImageAsset(name: "t03d")
  internal static let t03n = ImageAsset(name: "t03n")
  internal static let t04d = ImageAsset(name: "t04d")
  internal static let t04n = ImageAsset(name: "t04n")
  internal static let t05d = ImageAsset(name: "t05d")
  internal static let t05n = ImageAsset(name: "t05n")
  internal static let u00d = ImageAsset(name: "u00d")
  internal static let u00n = ImageAsset(name: "u00n")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
