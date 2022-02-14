// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Attabench",
    platforms: [
        .macOS(.v10_12), .iOS(.v10), .watchOS(.v3), .tvOS(.v10)
    ],
    products: [
        .library(name: "Attabench", targets: ["BenchmarkModel", "BenchmarkCharts", "BenchmarkRunner"]),
        .library(name: "Benchmarking", targets: ["Benchmarking", "BenchmarkIPC"]),
        .executable(name: "attachart", targets: ["attachart"]),
    ],
    dependencies: [
        .package(url: "https://github.com/attaswift/BigInt", .branch("master")),
        .package(url: "https://github.com/zwaldowski/GlueKit", .branch("zwaldowski/swift-5.0")),
        .package(url: "https://github.com/attaswift/OptionParser", from: "1.0.0")
    ],
    targets: [
        .target(name: "BenchmarkIPC", path: "BenchmarkIPC"),
        .target(
            name: "Benchmarking",
            dependencies: ["OptionParser", "BenchmarkIPC"],
            path: "Benchmarking",
            exclude: ["README.md"]),
        .target(name: "BenchmarkModel", dependencies: ["BigInt", "GlueKit"], path: "BenchmarkModel"),
        .target(name: "BenchmarkRunner", dependencies: ["Benchmarking", "BenchmarkModel"], path: "BenchmarkRunner"),
        .target(name: "BenchmarkCharts", dependencies: ["BenchmarkModel"], path: "BenchmarkCharts"),
        .executableTarget(name: "attachart", dependencies: ["BenchmarkModel", "BenchmarkCharts", "Benchmarking", "OptionParser"], path: "attachart"),
    ],
    swiftLanguageVersions: [.v5]
)
