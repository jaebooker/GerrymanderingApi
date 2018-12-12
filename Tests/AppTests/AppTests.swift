import App
import XCTest
import Vapor
import FluentSQLite
import Authentication
import Crypto
@testable import App
final class AppTests: XCTestCase {
   struct EmptyBody: Content {}

    func testable() throws -> Application {
        var config = Config.default()
        var services = Services.default()
        var env = Environment.testing
        try App.configure(&config, &env, &services)
        let app = try Application(config: config, environment: env, services: services)
        try App.boot(app)
        
        return app
    }
    func testNothing() throws {
        // add your tests here
        XCTAssert(true)
    }

    static let allTests = [
        ("testNothing", testNothing)
    ]
}
final class UserTests: XCTestCase {
    struct EmptyBody: Content {}
    let usersURI = "/api/users/"
    var app: Application!
    var conn: SQLiteConnection!
    
    override func setUp() {
        super.setUp()
        
        app = try! Application.testable()
       conn = try! app.newConnection(to: .sqlite).wait()
    }
    
    override func tearDown() {
        super.tearDown()
        
        conn.close()
    }
}
extension Application {
    static func testable() throws -> Application {
        var config = Config.default()
        var services = Services.default()
        var env = Environment.testing
        try App.configure(&config, &env, &services)
        let app = try Application(config: config, environment: env, services: services)
        try App.boot(app)
        
        return app
    }
    func sendRequest<Body>(to path: String, method: HTTPMethod, headers: HTTPHeaders = .init(), body: Body?, isLoggedInRequest: Bool = false) throws -> Response where Body: Content {
        let headers = headers
        let httpRequest = HTTPRequest(method: method, url: URL(string: path)!, headers: headers)
        let wrappedRequest = Request(http: httpRequest, using: self)
        if let body = body {
            try wrappedRequest.content.encode(body)
        }
        let responder = try make(Responder.self)
        
        return try responder.respond(to: wrappedRequest).wait()
    }
    struct EmptyBody: Content {}
}
