//
//  ExperienceController.swift
//  
//
//  Created by Kevin Bertrand on 10/10/2022.
//

import Fluent
import Vapor

struct ExperienceController: RouteCollection {
    // MARK: Properties
    
    // MARK: Route initialisation
    func boot(routes: RoutesBuilder) throws {
        let experienceGroup = routes.grouped("experience")
        experienceGroup.get(use: get)
        
        let tokenGroup = experienceGroup.grouped(UserToken.authenticator()).grouped(UserToken.guardMiddleware())
        tokenGroup.post(use: create)
    }
    
    // MARK: Routes functions
    /// Create experience
    private func create(req: Request) async throws -> Response {
        let serverIP = Environment.get("SERVER_HOSTNAME") ?? "127.0.0.1"
        let serverPort = Environment.get("SERVER_PORT").flatMap(Int.init(_:)) ?? 8080
        let createExperience = try req.content.decode(Experience.Create.self)
        
        try await Experience(title: createExperience.title,
                             company: createExperience.company,
                             location: createExperience.location,
                             startDate: createExperience.startDate,
                             endDate: createExperience.endDate,
                             icon: createExperience.icon).save(on: req.db)
        
        guard let experienceId = try await Experience.query(on: req.db)
            .filter(\.$title == createExperience.title)
            .filter(\.$company == createExperience.company)
            .first()?
            .id else {
            throw Abort(.internalServerError)
        }
        
        for mission in createExperience.missions {
            if let title = mission.title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
               let tasks = mission.tasks.replacingOccurrences(of: "/", with: "\\").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                _ = try await req.client.post("http://\(serverIP):\(serverPort)/mission/\(experienceId)/\(title)/\(tasks)", headers: req.headers)
            }
        }
        
        return GlobalFunctions.shared.formatResponse(status: .ok, body: .empty)
    }
    
    /// Getting experiences
    private func get(req: Request) async throws -> Response {
        let experiences = try await Experience.query(on: req.db)
            .sort(\.$endDate)
            .all()
        
        var experienceArray = [Experience.Getting]()
        
        for experience in experiences {
            if let experienceId = experience.id {
                let missions = try await Mission.query(on: req.db).filter(\.$experience.$id == experienceId).all()
                experienceArray.append(Experience.Getting(title: experience.title,
                                                          company: experience.company,
                                                          location: experience.location,
                                                          startDate: Int(experience.startDate.timeIntervalSince1970),
                                                          endDate: Int(experience.endDate?.timeIntervalSince1970 ?? 0),
                                                          icon: experience.icon,
                                                          missions: missions.map({ return .init(title: $0.title, tasks: $0.tasks)})))
            }
        }
        
        return GlobalFunctions.shared.formatResponse(status: .ok, body: .init(data: try JSONEncoder().encode(experienceArray)))
    }
}

