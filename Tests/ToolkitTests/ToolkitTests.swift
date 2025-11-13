//
//  ToolkitTests.swift
//  ToolkitTests
//
//  Unit tests for Toolkit framework
//

import XCTest
@testable import Toolkit

// MARK: - String Extensions Tests

final class StringExtensionsTests: XCTestCase {

    func testTrimmed() {
        XCTAssertEqual("  hello  ".trimmed, "hello")
        XCTAssertEqual("\n\thello\t\n".trimmed, "hello")
        XCTAssertEqual("hello".trimmed, "hello")
        XCTAssertEqual("   ".trimmed, "")
    }

    func testIsBlank() {
        XCTAssertTrue("".isBlank)
        XCTAssertTrue("   ".isBlank)
        XCTAssertTrue("\n\t".isBlank)
        XCTAssertFalse("hello".isBlank)
        XCTAssertFalse("  hello  ".isBlank)
    }

    func testIsValidEmail() {
        // Valid emails
        XCTAssertTrue("test@example.com".isValidEmail)
        XCTAssertTrue("user.name+tag@example.co.uk".isValidEmail)
        XCTAssertTrue("test123@test-domain.com".isValidEmail)

        // Invalid emails
        XCTAssertFalse("invalid.email".isValidEmail)
        XCTAssertFalse("@example.com".isValidEmail)
        XCTAssertFalse("test@".isValidEmail)
        XCTAssertFalse("test @example.com".isValidEmail)
        XCTAssertFalse("".isValidEmail)
    }

    func testTruncated() {
        let longString = "This is a long string"

        XCTAssertEqual(longString.truncated(to: 7), "This is...")
        XCTAssertEqual(longString.truncated(to: 7, addEllipsis: false), "This is")
        XCTAssertEqual(longString.truncated(to: 100), longString)
        XCTAssertEqual("".truncated(to: 5), "")
    }

    func testToURL() {
        XCTAssertNotNil("https://www.example.com".toURL)
        XCTAssertNotNil("http://example.com".toURL)
        XCTAssertNil("not a url".toURL)
        XCTAssertNil("".toURL)
    }
}

// MARK: - Collection Extensions Tests

final class CollectionExtensionsTests: XCTestCase {

    func testSafeSubscript() {
        let array = [1, 2, 3, 4, 5]

        XCTAssertEqual(array[safe: 0], 1)
        XCTAssertEqual(array[safe: 4], 5)
        XCTAssertNil(array[safe: 10])
        XCTAssertNil(array[safe: -1])

        let emptyArray: [Int] = []
        XCTAssertNil(emptyArray[safe: 0])
    }

    func testChunked() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]

        let chunked = array.chunked(into: 3)
        XCTAssertEqual(chunked.count, 3)
        XCTAssertEqual(chunked[0], [1, 2, 3])
        XCTAssertEqual(chunked[1], [4, 5, 6])
        XCTAssertEqual(chunked[2], [7, 8, 9])

        let unevenChunked = array.chunked(into: 4)
        XCTAssertEqual(unevenChunked.count, 3)
        XCTAssertEqual(unevenChunked[2], [9])

        let emptyArray: [Int] = []
        XCTAssertEqual(emptyArray.chunked(into: 2), [])
    }

    func testUniqueHashable() {
        let array = [1, 2, 2, 3, 3, 4, 5, 5]
        let uniqueArray = array.unique

        XCTAssertEqual(uniqueArray, [1, 2, 3, 4, 5])
        XCTAssertEqual(uniqueArray.count, 5)

        let strings = ["a", "b", "a", "c", "b"]
        XCTAssertEqual(strings.unique, ["a", "b", "c"])
    }

    func testUniqueByKeyPath() {
        struct Person {
            let id: Int
            let name: String
        }

        let people = [
            Person(id: 1, name: "Alice"),
            Person(id: 2, name: "Bob"),
            Person(id: 1, name: "Alice2"),
            Person(id: 3, name: "Charlie")
        ]

        let uniquePeople = people.unique(by: \.id)
        XCTAssertEqual(uniquePeople.count, 3)
        XCTAssertEqual(uniquePeople[0].name, "Alice")
        XCTAssertEqual(uniquePeople[1].name, "Bob")
        XCTAssertEqual(uniquePeople[2].name, "Charlie")
    }
}

// MARK: - Optional Extensions Tests

final class OptionalExtensionsTests: XCTestCase {

    func testOrThrow() {
        let value: Int? = 42
        let nilValue: Int? = nil

        XCTAssertNoThrow(try value.orThrow(ToolkitError.notFound))
        XCTAssertEqual(try? value.orThrow(ToolkitError.notFound), 42)

        XCTAssertThrowsError(try nilValue.orThrow(ToolkitError.notFound)) { error in
            XCTAssertEqual(error as? ToolkitError, .notFound)
        }
    }

    func testOr() {
        let value: Int? = 42
        let nilValue: Int? = nil

        XCTAssertEqual(value.or(0), 42)
        XCTAssertEqual(nilValue.or(100), 100)

        let stringValue: String? = "hello"
        let nilString: String? = nil
        XCTAssertEqual(stringValue.or("default"), "hello")
        XCTAssertEqual(nilString.or("default"), "default")
    }
}

// MARK: - Date Extensions Tests

final class DateExtensionsTests: XCTestCase {

    func testISO8601String() {
        let date = Date(timeIntervalSince1970: 0)
        let iso8601 = date.iso8601String

        XCTAssertFalse(iso8601.isEmpty)
        XCTAssertTrue(iso8601.contains("1970"))
    }

    func testStartOfDay() {
        let date = Date()
        let startOfDay = date.startOfDay

        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: startOfDay)

        XCTAssertEqual(components.hour, 0)
        XCTAssertEqual(components.minute, 0)
        XCTAssertEqual(components.second, 0)
    }

    func testIsToday() {
        let today = Date()
        XCTAssertTrue(today.isToday)

        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        XCTAssertFalse(yesterday.isToday)

        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        XCTAssertFalse(tomorrow.isToday)
    }

    func testIsPastAndIsFuture() {
        let past = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        XCTAssertTrue(past.isPast)
        XCTAssertFalse(past.isFuture)

        let future = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        XCTAssertFalse(future.isPast)
        XCTAssertTrue(future.isFuture)
    }

    func testAddingDays() {
        let date = Date()

        let tomorrow = date.adding(days: 1)
        XCTAssertNotNil(tomorrow)

        let yesterday = date.adding(days: -1)
        XCTAssertNotNil(yesterday)

        if let tomorrow = tomorrow {
            let daysDiff = Calendar.current.dateComponents([.day], from: date, to: tomorrow).day
            XCTAssertEqual(daysDiff, 1)
        }
    }
}

// MARK: - Result Extensions Tests

final class ResultExtensionsTests: XCTestCase {

    func testSuccessValue() {
        let success: Result<Int, Error> = .success(42)
        let failure: Result<Int, Error> = .failure(ToolkitError.notFound)

        XCTAssertEqual(success.successValue, 42)
        XCTAssertNil(failure.successValue)
    }

    func testFailureError() {
        let success: Result<Int, ToolkitError> = .success(42)
        let failure: Result<Int, ToolkitError> = .failure(.notFound)

        XCTAssertNil(success.failureError)
        XCTAssertEqual(failure.failureError, .notFound)
    }
}

// MARK: - Dictionary Extensions Tests

final class DictionaryExtensionsTests: XCTestCase {

    func testMerged() {
        let dict1 = ["a": 1, "b": 2, "c": 3]
        let dict2 = ["b": 20, "d": 4]

        let merged = dict1.merged(with: dict2)

        XCTAssertEqual(merged["a"], 1)
        XCTAssertEqual(merged["b"], 20) // dict2 value takes precedence
        XCTAssertEqual(merged["c"], 3)
        XCTAssertEqual(merged["d"], 4)
        XCTAssertEqual(merged.count, 4)

        let emptyDict: [String: Int] = [:]
        let mergedWithEmpty = dict1.merged(with: emptyDict)
        XCTAssertEqual(mergedWithEmpty, dict1)
    }
}

// MARK: - ToolkitError Tests

final class ToolkitErrorTests: XCTestCase {

    func testErrorEquality() {
        let error1 = ToolkitError.notFound
        let error2 = ToolkitError.notFound
        let error3 = ToolkitError.invalidValue("test")
        let error4 = ToolkitError.invalidValue("test")
        let error5 = ToolkitError.invalidValue("other")

        XCTAssertEqual(error1, error2)
        XCTAssertEqual(error3, error4)
        XCTAssertNotEqual(error3, error5)
        XCTAssertNotEqual(error1, error3)
    }
}

