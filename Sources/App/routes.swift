import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: UserController())
    try app.register(collection: ProfileController())
    try app.register(collection: EducationController())
    try app.register(collection: SubjectController())
    try app.register(collection: ExperienceController())
}
