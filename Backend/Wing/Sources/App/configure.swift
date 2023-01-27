import Fluent
import FluentPostgresDriver
import Vapor


extension Environment {
    static var databaseURL: URL {
        guard let urlString = Environment.get("DATABASE_URL"), let url = URL(string: urlString) else {
                    fatalError("DATABASE_URL not configured")
                }
                return url
    }
    
    
}


// configures your application
public func configure(_ app: Application) throws {

    //Add database configuration, for production uses

    
    if let databaseURL = Environment.get("DATABASE_URL"), var postgresConfig = PostgresConfiguration(url: databaseURL) {
        postgresConfig.tlsConfiguration = .makeClientConfiguration()
        postgresConfig.tlsConfiguration?.certificateVerification = .none
        app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
    } else {
        fatalError("DATABASE URL not configured")
    }
    

    //try app.databases.use(.postgres(url: Environment.databaseURL), as: .psql)
    
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
