import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: UserController())
    try app.register(collection: ProfileController())
    try app.register(collection: EducationController())
    try app.register(collection: SubjectController())
    try app.register(collection: ExperienceController())
    try app.register(collection: MissionController())
    try app.register(collection: ProjectController())
    try app.register(collection: SkillController())
    try app.register(collection: TrainingController())
}
