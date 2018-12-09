//
//  UserController.swift
//  App
//
//  Created by Jaeson Booker on 12/8/18.
//

import Foundation
import Vapor
import Fluent
import FluentSQLite
import Crypto

class UserController: RouteCollection {
    //get endpoints and make post to API, using Futures
    func boot(router: Router) throws {
        let group = router.grouped("api", "users")
        group.post(User.self, at: "register", use: registerUserHandler)
    }
}

private extension UserController {
    
    func registerUserHandler(_ request: Request, newUser: User) throws -> Future<HTTPResponseStatus> {
        //take user from request and search database
        return try User.query(on: request).filter(\.email == newUser.email).first().flatMap
            { existingUser in
            //check if user already exists
            guard existingUser == nil else {
                throw Abort(.badRequest, reason: "a user with this email already exists" , identifier: nil)
            }
            //encrypt password
            let digest = try request.make(BCryptDigest.self)
            let hashedPassword = try digest.hash(newUser.password)
            let persistedUser = User(id: nil, email: newUser.email, password: hashedPassword)
            //return user and add them to database
            return persistedUser.save(on: request).transform(to: .created)
        }
    }
}
