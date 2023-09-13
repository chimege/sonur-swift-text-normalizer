// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TextNormalizerSwift",
    products: [
        // Products define the executables and libries a package produces, and make them visible to other packages.
        .library(
            name: "TextNormalizerSwift",
            targets: ["TextNormalizerSwift"]
        ),

        .library(
            name: "SwiftyPyString",
            targets: ["SwiftyPyString"]
        ),

        .library(name: "SwiftyPyRegex", targets: ["SwiftyPyRegex"]),
    ],

    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/chimege/espeak-ng-spm.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TextNormalizerSwift",
            dependencies: [
                .product(name: "libespeak-ng", package: "espeak-ng-spm"),
                .product(name: "espeak-ng-data", package: "espeak-ng-spm"),
                .product(name: "libsonic", package: "espeak-ng-spm"),
                "SwiftyPyString", "SwiftyPyRegex"
            ],
            resources: [
                .process("noun_conj.json"),
                .process("verb_conj.json"),
                .process("emoji_list.json"),
                .process("symbols.json"),
                .process("m_abbrev.csv"),
                .process("config.json"),
            ]
        ),

        .target(
            name: "SwiftyPyString",
            dependencies: []
        ),

        .target(name: "SwiftyPyRegex", dependencies: []),

        // .executableTarget(
        //     name: "tester",

        //     dependencies: [
        //         "TextNormalizerSwift",
        //         "SwiftyPyString",
        //         "SwiftyPyRegex",
        //     ], resources: [
        //         .process("tts_tests.json"),
               
        //     ]),
    ]
)
