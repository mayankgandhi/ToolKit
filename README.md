# Toolkit Framework

A shared utility library providing useful extensions and utilities for Swift applications.

## Features

### String Extensions
- `trimmed` - Remove leading and trailing whitespace
- `isBlank` - Check if string is empty or only whitespace
- `isValidEmail` - Validate email format
- `truncated(to:addEllipsis:)` - Truncate strings with optional ellipsis
- `toURL` - Convert string to URL

### Collection Extensions
- `[safe: index]` - Safe array subscripting that returns nil instead of crashing
- `chunked(into:)` - Split arrays into chunks of specified size
- `unique` - Get unique elements while preserving order
- `unique(by:)` - Get unique elements by key path

### Optional Extensions
- `orThrow(_:)` - Unwrap optional or throw error
- `or(_:)` - Provide default value for nil optionals

### Date Extensions
- `iso8601String` - Format date as ISO 8601 string
- `startOfDay` - Get date at start of day
- `isToday` - Check if date is today
- `isPast` / `isFuture` - Check date relative to now
- `adding(days:)` - Add/subtract days from date

### Result Extensions
- `successValue` - Extract success value or nil
- `failureError` - Extract failure error or nil

### Dictionary Extensions
- `merged(with:)` - Merge two dictionaries

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/ToolKit.git", from: "1.0.0")
]
```

### Tuist

This project uses Tuist for project generation. To work with the project:

```bash
# Install Tuist
curl -Ls https://install.tuist.io | bash

# Generate Xcode project
tuist generate
```

## Running Tests

### Using Xcode

1. Generate the project: `tuist generate`
2. Open `Toolkit.xcodeproj`
3. Press `⌘+U` to run tests

### Using Command Line

#### On macOS with Xcode:

```bash
# Generate project
tuist generate

# Build and test
xcodebuild test \
  -scheme Toolkit \
  -destination 'platform=macOS' \
  -configuration Debug
```

#### Using Swift Package Manager:

```bash
# Build
swift build

# Run tests
swift test

# Run tests with coverage
swift test --enable-code-coverage
```

## Test Coverage

The test suite includes comprehensive tests for:

- ✅ String Extensions (5 test cases, 18 assertions)
- ✅ Collection Extensions (4 test cases, 20+ assertions)
- ✅ Optional Extensions (2 test cases, 7 assertions)
- ✅ Date Extensions (5 test cases, 15+ assertions)
- ✅ Result Extensions (2 test cases, 4 assertions)
- ✅ Dictionary Extensions (1 test case, 6 assertions)
- ✅ Custom Errors (1 test case, 6 assertions)

**Total: 20+ test cases with 75+ assertions**

## Continuous Integration

This project uses GitHub Actions for automated testing on:

- macOS (Xcode)
- iOS Simulator
- Linux (Swift Package Manager)

The CI pipeline runs on:
- Every push to `main`, `develop`, or `claude/**` branches
- Every pull request to `main` or `develop` branches
- Manual workflow dispatch

### Workflow Jobs

1. **test-macos**: Runs tests on macOS and iOS Simulator using Xcode
2. **test-linux**: Runs tests on Linux using Swift Package Manager
3. **lint**: Runs SwiftLint for code quality checks

## Requirements

- Swift 6.0+
- iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+

## License

This project is available under the MIT license.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Write tests for your changes
4. Ensure all tests pass
5. Commit your changes (`git commit -m 'Add some amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Development

### Project Structure

```
ToolKit/
├── Sources/
│   └── Toolkit/
│       └── Toolkit.swift          # Main framework code
├── Tests/
│   └── ToolkitTests/
│       └── ToolkitTests.swift     # Test suite
├── .github/
│   └── workflows/
│       └── tests.yml              # CI/CD configuration
├── Project.swift                   # Tuist configuration
├── Package.swift                   # SPM configuration
└── README.md                       # This file
```

### Adding New Features

1. Add your extension/utility to `Sources/Toolkit/Toolkit.swift`
2. Add corresponding tests to `Tests/ToolkitTests/ToolkitTests.swift`
3. Update this README with the new functionality
4. Ensure all tests pass before committing

### Code Style

- Use clear, descriptive names
- Add documentation comments for public APIs
- Keep functions focused and small
- Write tests for all new functionality
- Follow Swift API Design Guidelines
