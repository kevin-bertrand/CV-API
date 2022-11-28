//
//  NameManager.swift
//
//
//  Created by Kevin Bertrand on 28/11/2022.
//

import Foundation

enum NameManager {
    enum Education: String {
        case schema = "education"
        case endingDate = "ending_date"
        case documentPath = "document_path"
        case school, title, level, location, icon
    }
    
    enum Experience: String {
        case schema = "experience"
        case startDate = "start_date"
        case endDate = "end_date"
        case title, company, location, icon
    }
    
    enum Mission: String {
        case schema = "mission"
        case experienceId = "experience_id"
        case title, tasks
    }
    
    enum Profile: String {
        case schema = "profile"
        case firstname, lastname, email, phone, city, description, title, github, linkedin, codingames
    }
    
    enum Project: String {
        case schema = "project"
        case mediaPath = "media_path"
        case title, description, company, date, github, category
    }
    
    enum Skill: String {
        case schema = "skill"
        case title, image, category
    }
    
    enum Subject: String {
        case schema = "subject"
        case educationId = "education_id"
        case title
    }
    
    enum Training: String {
        case schema = "trainings"
        case documentPath = "document_path"
        case title, organization, date, icon
    }
    
    enum User: String {
        case schema = "user"
        case passwordHash = "password_hash"
        case email
    }
    
    enum UserToken: String {
        case schema = "user_token"
        case userId = "user_id"
        case value
    }
    
    enum Enumeration: String {
        case skillsCategories = "skills_categories"
        case projectCategories = "project_categories"
    }
}
