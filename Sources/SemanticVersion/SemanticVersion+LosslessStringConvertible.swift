import Foundation

/// Extends ``SemanticVersion`` with conformance to `LosslessStringConvertible`
extension SemanticVersion: LosslessStringConvertible {
    
    /// A `Regex` from [Semantic Versioning 2.0.0](http://semver.org).
    private static let re =
    /^(?<major>0|[1-9]\d*)\.(?<minor>0|[1-9]\d*)\.(?<patch>0|[1-9]\d*)(?:-(?<prerelease>(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+(?<buildMetadata>[0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$/

    /// The maximum length of a `String` accepted by the parser.
    ///
    /// The initialiser is reachable from `Codable` decoding of untrusted input,
    /// so the length is bounded before the regular expression runs. This caps the
    /// work performed on a single value and any opportunity for the matcher to
    /// backtrack pathologically. The limit is far larger than any practical
    /// version string.
    private static let maxDescriptionLength = 256

    /// Initialise a ``SemanticVersion`` from a `String` value
    ///
    /// If the `String` value passed is not a valid Semantic Versioning string, then a `nil` will
    /// be returned. A `nil` is also returned for inputs longer than 256 characters, or whose
    /// major, minor, or patch numbers exceed `UInt.max`.
    ///
    /// - Parameter description: A `String` to attempt to represent as a ``SemanticVersion``.
    public init?(_ description: String) {

        guard description.count <= SemanticVersion.maxDescriptionLength else { return nil }

        guard
            let match = try? SemanticVersion.re.wholeMatch(in: description),
            let major = UInt(match.major),
            let minor = UInt(match.minor),
            let patch = UInt(match.patch)
        else { return nil }
        
        self.major = major
        self.minor = minor
        self.patch = patch
        
        prerelease = match.prerelease?.components(separatedBy: ".") ?? []
        buildMetadata = match.buildMetadata?.components(separatedBy: ".") ?? []
        
    }
    
    /// A `String` representation conforming to [Semantic Versioning 2.0.0](http://semver.org).
    public var description: String {
        
        var result = "\(major).\(minor).\(patch)"
        
        if !prerelease.isEmpty {
            result += "-" + prerelease.joined(separator: ".")
        }
        
        if !buildMetadata.isEmpty {
            result += "+" + buildMetadata.joined(separator: ".")
        }
        
        return result
        
    }
    
}
