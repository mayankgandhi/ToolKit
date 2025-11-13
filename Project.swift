import ProjectDescription

let project = Project(
    name: "Toolkit",
    organizationName: "m",
    settings: .settings(
        defaultSettings: .recommended
    ),
    targets: [
        .target(
            name: "Toolkit",
            destinations: [.iPhone, .iPad, .mac],
            product: .framework,
            bundleId: "m.toolkit",
            sources: [
                "Sources/**"
            ],
            dependencies: [
                // No external dependencies needed for now
            ],
            settings: .settings(
                base: [
                    "SWIFT_VERSION": "6.0",
                    "IPHONEOS_DEPLOYMENT_TARGET": "26.0"
                ],
                configurations: [
                    .debug(name: "Debug"),
                    .release(name: "Release")
                ],
                defaultSettings: .recommended
            )
        ),
        .target(
            name: "ToolkitTests",
            destinations: [.iPhone, .iPad, .mac],
            product: .unitTests,
            bundleId: "m.toolkit.tests",
            sources: [
                "Tests/**"
            ],
            dependencies: [
                .target(name: "Toolkit")
            ]
        )
    ]
)

