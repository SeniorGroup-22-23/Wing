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

    // register routes
    try routes(app)
}
