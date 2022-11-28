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
    }
    
    // MARK: Routes functions
    /// Create a training
    private func create(req: Request) async throws -> Response {
        let training = try req.content.decode(Training.self)
        try await training.save(on: req.db)
        return GlobalFunctions.shared.formatResponse(status: .created, body: .empty)
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

