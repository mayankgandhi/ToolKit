//
//  Toolkit.swift
//  Toolkit
//
//  Shared extensions and utilities for use across apps
//

import Foundation
import RegexBuilder

// MARK: - String Extensions

public extension String {
    /// Validates if the string is a valid email address
    var isValidEmail: Bool {
        // Email regex pattern
        let emailPattern = /[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}/

        // Check if the entire string matches the pattern
        return self.wholeMatch(of: emailPattern) != nil
    }
}
