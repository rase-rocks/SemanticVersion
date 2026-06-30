import Foundation

public typealias SemVer = SemanticVersion

/// A version conforming to [Semantic Versioning 2.0.0](http://semver.org).
///
/// > Important: This implementation does not support prefixing version strings
public struct SemanticVersion {
    
    /// The MAJOR version.
    public let major: UInt
    
    /// The MINOR version.
    public let minor: UInt
    
    /// The PATCH version.
    public let patch: UInt
    
    /// The pre-release identifiers
    public let prerelease: [String]
    
    /// The build metadata. Metadata is ignored for hashing and equality operations
    public let buildMetadata: [String]
    
    /// A Boolean value indicating whether the version is pre-release version
    public var isPrerelease: Bool {
        return !prerelease.isEmpty
    }
    
    /// Initialise a ``SemanticVersion`` from its individual components.
    ///
    /// - Parameter major: The MAJOR version.
    /// - Parameter minor: The MINOR version.
    /// - Parameter patch: The PATCH version.
    /// - Parameter prerelease: The pre-release identifiers.
    /// - Parameter buildMetadata: The build metadata identifiers. Ignored for equality, hashing and ordering.
    public init(
        major: UInt,
        minor: UInt,
        patch: UInt,
        prerelease: [String],
        buildMetadata: [String]
    ) {
        
        self.major = major
        self.minor = minor
        self.patch = patch
        self.prerelease = prerelease
        self.buildMetadata = buildMetadata
        
    }
    
}

extension SemanticVersion: Sendable {}
