//
//  User.swift
//  App
//
//  Created by Jaeson Booker on 12/8/18.
//

import Foundation
import Vapor
import Fluent
import FluentSQLite
import Authentication

struct User: Content, SQLiteUUIDModel, Migration {
    var id: UUID?
    private(set) var email: String
    private(set) var password: String
}
