import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // Check if DATABASE_URL is available
       if let databaseURL = Environment.get("DATABASE_URL"), var postgresConfig = PostgresConfiguration(url: databaseURL) {
           postgresConfig.tlsConfiguration = .forClient(certificateVerification: .none)
           app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
       } else {
           // Configure for local development without TLS
           app.databases.use(.postgres(
               hostname: "localhost",
               username: "postgres",
               password: "",
               database: "postgres"
           ), as: .psql)
       }

       // Configure HTTPS
       let certificatePath = "/Users/brynhaines/Wing/cert.pem"
       let privateKeyPath = "/Users/brynhaines/Wing/key.pem"

       guard let tlsConfiguration = try? TLSConfiguration.forServer(
           certificateChain: [.file(certificatePath)],
           privateKey: .file(privateKeyPath)
       ) else {
           throw Abort(.internalServerError)
       }

       app.http.server.configuration.hostname = "127.0.0.1"
       app.http.server.configuration.port = 8443
       app.http.server.configuration.tlsConfiguration = tlsConfiguration

       // Increase max request payload size
       app.routes.defaultMaxBodySize = "1000kb"
    
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
    app.migrations.add(CreateBlocks())

    
    // register routes
    try propmtRoutes(app)
    try blockRoutes(app)
    try userRoutes(app)
    try friendRoutes(app)
    try profilePreviewRoutes(app)
    try matchRoutes(app)
    try wingRoutes(app)
    try photoRoutes(app)

}
