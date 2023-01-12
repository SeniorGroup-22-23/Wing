import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {

    //Add database configuration
    //All default setup on local host 
    app.databases.use(.postgres(
        hostname: "localhost",
        username: "postgres",
        password: "",
        database: "postgres"
    ), as: .psql)

    //Migrations to run
    app.migrations.add(CreateUsers())
    app.migrations.add(CreatePrompts())
    app.migrations.add(CreatePromptResponses())
    app.migrations.add(CreatePhotos())
    app.migrations.add(CreateProfiles())
    app.migrations.add(CreateProfilePreviews())
    app.migrations.add(CreateFriendships())
    app.migrations.add(CreateWings())
    app.migrations.add(CreateSwipes())
    app.migrations.add(CreateMatches())
    app.migrations.add(CreateMessages())
    app.migrations.add(CreateBlocks())

    // run SQL shell script
    
    
    // register routes
    try propmtRoutes(app)
    try blockRoutes(app)
    try userRoutes(app)
    try friendRoutes(app)
    try profilePreviewRoutes(app)
    try matchRoutes(app)
    try wingRoutes(app)

}
