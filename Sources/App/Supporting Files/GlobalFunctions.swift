//
//  GlobalFunctions.swift
//  
//
//  Created by Kevin Bertrand on 28/11/2022.
//


import Foundation
import Vapor

class GlobalFunctions {
    static let shared = GlobalFunctions()
    
    /// Getting the connected user
    func getUserAuthFor(_ req: Request) throws -> User {
        return try req.auth.require(User.self)
    }
    
    /// Formating response
    func formatResponse(status: HTTPResponseStatus, body: Response.Body) -> Response {
        var headers = HTTPHeaders()
        headers.add(name: .contentType, value: "application/json")
        return .init(status: status, headers: headers, body: body)
    }
}
