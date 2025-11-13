//
//  Toolkit.swift
//  Toolkit
//
//  Shared extensions and utilities for use across apps
//

import Foundation

// MARK: - String Extensions

public extension String {
    /// Removes leading and trailing whitespace and newlines
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Checks if string is empty or contains only whitespace
    var isBlank: Bool {
        self.trimmed.isEmpty
    }

    /// Validates if the string is a valid email format
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: self)
    }

    /// Truncates string to specified length and adds ellipsis if needed
    func truncated(to length: Int, addEllipsis: Bool = true) -> String {
        guard self.count > length else { return self }
        let endIndex = self.index(self.startIndex, offsetBy: length)
        let truncated = String(self[..<endIndex])
        return addEllipsis ? truncated + "..." : truncated
    }

    /// Converts string to URL if valid
    var toURL: URL? {
        URL(string: self)
    }
}

// MARK: - Collection Extensions

public extension Collection {
    /// Safe subscript that returns nil instead of crashing
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

public extension Array {
    /// Splits array into chunks of specified size
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }

    /// Returns unique elements while preserving order
    func unique<T: Hashable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        var seen = Set<T>()
        return filter { seen.insert($0[keyPath: keyPath]).inserted }
    }
}

public extension Array where Element: Hashable {
    /// Returns unique elements while preserving order
    var unique: [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}

// MARK: - Optional Extensions

public extension Optional {
    /// Returns the wrapped value or throws an error
    func orThrow(_ error: Error) throws -> Wrapped {
        guard let value = self else { throw error }
        return value
    }

    /// Returns the wrapped value or a default value computed by closure
    func or(_ defaultValue: @autoclosure () -> Wrapped) -> Wrapped {
        self ?? defaultValue()
    }
}

// MARK: - Date Extensions

public extension Date {
    /// Formats date to ISO 8601 string
    var iso8601String: String {
        ISO8601DateFormatter().string(from: self)
    }

    /// Returns date with time set to start of day
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    /// Checks if date is today
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    /// Checks if date is in the past
    var isPast: Bool {
        self < Date()
    }

    /// Checks if date is in the future
    var isFuture: Bool {
        self > Date()
    }

    /// Adds specified number of days to date
    func adding(days: Int) -> Date? {
        Calendar.current.date(byAdding: .day, value: days, to: self)
    }
}

// MARK: - Result Extensions

public extension Result {
    /// Returns the success value or nil
    var successValue: Success? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }

    /// Returns the failure error or nil
    var failureError: Failure? {
        if case .failure(let error) = self {
            return error
        }
        return nil
    }
}

// MARK: - Dictionary Extensions

public extension Dictionary {
    /// Merges two dictionaries, with the other dictionary's values taking precedence
    func merged(with other: [Key: Value]) -> [Key: Value] {
        var result = self
        other.forEach { result[$0.key] = $0.value }
        return result
    }
}

// MARK: - Custom Errors

public enum ToolkitError: Error, Equatable {
    case invalidValue(String)
    case operationFailed(String)
    case notFound
}

