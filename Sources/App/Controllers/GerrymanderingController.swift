import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class GerrymanderingController {
    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[GerryMandering]> {
        return GerryMandering.query(on: req).all()
    }

    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<GerryMandering> {
        return try req.content.decode(GerryMandering.self).flatMap { gerrymandering in
            return gerrymandering.save(on: req)
        }
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(GerryMandering.self).flatMap { gerrymandering in
            return gerrymandering.delete(on: req)
        }.transform(to: .ok)
    }
}
