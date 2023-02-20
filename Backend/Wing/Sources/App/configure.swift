import Fluent
import FluentPostgresDriver
import Vapor
import JWT

// configures your application
public func configure(_ app: Application) throws {
    
    //app.jwt.signers.use(.hs256(key: Environment.get("KEY")!))
    app.jwt.signers.use(.hs256(key: "wing-key-2023")) //select jwt algorithm and key 

    //Try to run in prod, if not set up avail try locally 
    if let databaseURL = Environment.get("DATABASE_URL"), var postgresConfig = PostgresConfiguration(url: databaseURL) {
        postgresConfig.tlsConfiguration = .makeClientConfiguration()
        postgresConfig.tlsConfiguration?.certificateVerification = .none
        app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
        
    } else {
        app.databases.use(.postgres(
                hostname: "localhost",
                username: "postgres",
                password: "",
                database: "postgres"
            ), as: .psql)
    }
    
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

    
    // register routes
    try propmtRoutes(app)
    try blockRoutes(app)
    try userRoutes(app)
    try friendRoutes(app)
    try profilePreviewRoutes(app)
    try matchRoutes(app)
    try wingRoutes(app)

}
