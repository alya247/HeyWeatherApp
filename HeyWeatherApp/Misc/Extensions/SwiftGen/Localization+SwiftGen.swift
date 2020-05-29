// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// Current
  internal static let current = L10n.tr("Localizable", "current")
  /// Done
  internal static let done = L10n.tr("Localizable", "done")
  /// Email
  internal static let email = L10n.tr("Localizable", "email")
  /// LogOut
  internal static let logOut = L10n.tr("Localizable", "logOut")
  /// Max Temperature
  internal static let maxTemperature = L10n.tr("Localizable", "maxTemperature")
  /// Min Temperature
  internal static let minTemperature = L10n.tr("Localizable", "minTemperature")
  /// Password
  internal static let password = L10n.tr("Localizable", "password")
  /// Search
  internal static let search = L10n.tr("Localizable", "search")
  /// SignIn
  internal static let signIn = L10n.tr("Localizable", "signIn")
  /// Two Weeks
  internal static let twoWeeks = L10n.tr("Localizable", "twoWeeks")
  /// Week
  internal static let week = L10n.tr("Localizable", "week")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
