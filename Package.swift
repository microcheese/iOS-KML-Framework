// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package =   Package(
  name: "iOS-KML-Framework",
  platforms: [.iOS(.v13)],
  products: [
    .library(name: "iOS-KML-Framework", targets: ["iOS-KML-Framework"])
  ],
  targets: [
    .target(name: "iOS-KML-Framework", path: "iOS-KML-Framework")
  ],
  swiftLanguageVersions: [.v5]
)
