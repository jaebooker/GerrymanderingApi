import FluentSQLite
import Vapor

/// A single entry of a Gerrymandering list
final class GerryMandering: SQLiteModel {
    /// The unique identifier for this entry
    var id: Int?
    /// Name, office holding(state senator, etc.), and place representing (California, etc.)
    var name: String
    var officeType: String
    var representing: String

    /// Creates a new entry
    init(id: Int? = nil, name: String, officeType: String, representing: String) {
        self.id = id
        self.name = name
        self.officeType = officeType
        self.representing = representing
    }
}

/// Allows `Todo` to be used as a dynamic migration.
extension GerryMandering: Migration { }

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension GerryMandering: Content { }

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension GerryMandering: Parameter { }
