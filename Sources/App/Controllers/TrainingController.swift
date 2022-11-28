//
//  TrainingController.swift
//  
//
//  Created by Kevin Bertrand on 11/10/2022.
//

import Fluent
import Vapor

struct TrainingController: RouteCollection {
    // MARK: Properties
    
    // MARK: Route initialisation
    func boot(routes: RoutesBuilder) throws {
        let trainingGroup = routes.grouped("training")
        trainingGroup.get(use: get)
        
        let tokenGroup = trainingGroup.grouped(UserToken.authenticator()).grouped(UserToken.guardMiddleware())
        tokenGroup.post(use: create)
        tokenGroup.patch("icon", ":id", ":key", use: addIcon)
        tokenGroup.patch("document", ":id", ":key", use: addDocument)
    }
    
    // MARK: Routes functions
    /// Create a training
    private func create(req: Request) async throws -> Response {
        let training = try req.content.decode(Training.self)
        try await training.save(on: req.db)
        return GlobalFunctions.shared.formatResponse(status: .created, body: .empty)
    }
    
    /// Adding icon to trainings
    private func addIcon(req: Request) async throws -> Response {
        guard let key = req.parameters.get("key"),
              let trainingOrganization = req.parameters.get("id") else {
            throw Abort(.notAcceptable)
        }
        let path = "/var/www/kevin.desyntic.com/public/img/\(key)"
        
        try await Training.query(on: req.db)
            .set(\.$icon, to: key)
            .filter(\.$organization == trainingOrganization)
            .update()
        
        try req.body.collect()
            .unwrap(or: Abort(.noContent))
            .flatMap { req.fileio.writeFile($0, at: path)}
            .wait()
        
        return GlobalFunctions.shared.formatResponse(status: .ok, body: .empty)
    }
    
    /// Adding document to trainings
    private func addDocument(req: Request) async throws -> Response {
        guard let key = req.parameters.get("key"),
              let trainingId = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.notAcceptable)
        }
        let path = "/var/www/kevin.desyntic.com/public/docs/\(key)"
        
        try await Training.query(on: req.db)
            .set(\.$documentPath, to: key)
            .filter(\.$id == trainingId)
            .update()
        
        try req.body.collect()
            .unwrap(or: Abort(.noContent))
            .flatMap { req.fileio.writeFile($0, at: path)}
            .wait()
        
        return GlobalFunctions.shared.formatResponse(status: .ok, body: .empty)
    }
    
    /// Getting all trainings
    private func get(req: Request) async throws -> Response {
        let trainings = try await Training.query(on: req.db).sort(\.$date).all()
        
        var trainingsArray = [Training.Getting]()
        
        for training in trainings {
            trainingsArray.append(Training.Getting(title: training.title,
                                                   organization: training.organization,
                                                   date: Int(training.date.timeIntervalSince1970),
                                                   documentPath: training.documentPath,
                                                   icon: training.icon))
        }
        
        return GlobalFunctions.shared.formatResponse(status: .ok, body: .init(data: try JSONEncoder().encode(trainingsArray)))
    }
}

