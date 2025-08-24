// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "QuestionBank",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "QuestionBankCore",
            targets: ["QuestionBankCore"]
        ),
    ],
    targets: [
        .target(
            name: "QuestionBankCore",
            resources: [
                .process("Resources/questions.json")
            ]
        ),
        .testTarget(
            name: "QuestionBankCoreTests",
            dependencies: ["QuestionBankCore"]
        ),
    ]
)
