import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {

    app.databases.use(.postgres(
        hostname: "localhost",
        username: "postgres",
        password: "", //change in psql
        database: "postgres"
    ), as: .psql)

    //Migrations to run
    app.migrations.add(CreateUsers())

    // register routes
    try routes(app)
}
