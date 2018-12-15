import Vapor

/// Controls basic CRUD operations on model.
final class GerrymanderingController {
    //index through entries, using Future Type
    func index(_ req: Request) throws -> Future<[GerryMandering]> {
        return GerryMandering.query(on: req).all()
    }

    /// Saves a decoded model to the database.
    func create(_ req: Request) throws -> Future<GerryMandering> {
        return try req.content.decode(GerryMandering.self).flatMap { gerrymandering in
            return gerrymandering.save(on: req)
        }
    }

    /// Deletes a parameterized model.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(GerryMandering.self).flatMap { gerrymandering in
            return gerrymandering.delete(on: req)
        }.transform(to: .ok)
    }
}
