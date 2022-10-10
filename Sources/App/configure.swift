import Fluent
import FluentPostgresDriver
import FluentSQLiteDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // Config max upload file size
    app.routes.defaultMaxBodySize = "10mb"

    // Configure DB
    if app.environment == .production {
        app.databases.use(.postgres(
            hostname: Environment.get("DATABASE_HOST") ?? "localhost",
            port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
            username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
            password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
            database: Environment.get("DATABASE_NAME") ?? "vapor_database"
        ), as: .psql)
    } else {
        app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    }
    
    // Configuring files middleware
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Leaf configuration
    app.views.use(.leaf)

    // Server configuration
    app.http.server.configuration.hostname = Environment.get("SERVER_HOSTNAME") ?? "127.0.0.1"
    app.http.server.configuration.port = Environment.get("SERVER_PORT").flatMap(Int.init(_:)) ?? 8080
    
    // Migration
    app.migrations.add(CreateEnumerations())
    app.migrations.add(CreateProfile())
    app.migrations.add(CreateEducation())
    app.migrations.add(CreateExperience())
    app.migrations.add(CreateMission())
    app.migrations.add(CreateProject())
    app.migrations.add(CreateSkill())
    app.migrations.add(CreateSubject())
    app.migrations.add(CreateTraining())
    app.migrations.add(CreateUser())
    app.migrations.add(CreateUserToken())
    app.migrations.add(CreateDefaultAdmin())

    // register routes
    try routes(app)
}
