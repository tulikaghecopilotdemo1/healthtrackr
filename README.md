# HealthTrackr: My Personal Health Project

Welcome to my personal health project! More detail to come...
# Healthtrackr.Api.Activity

Healthtrackr.Api.Activity is a RESTful API for managing and retrieving user activity records as part of the HealthTrackr suite.

## Features

- Retrieve all activity records with pagination support.
- Retrieve activity records for a specific date.
- Health check endpoint for liveness.
- Swagger/OpenAPI documentation for easy API exploration.
- CORS support for cross-origin requests.
- this is also for demo purposes
- this is not a production usecase 

## Endpoints

### `GET /api/activity`

Retrieves all activity records, supporting query parameters for filtering and pagination.

- **Response:** `200 OK` with a list of activity records and pagination metadata in the `X-Pagination` header.
- **Error:** `500 Internal Server Error` on failure.

### `GET /api/activity/{activityDate}`

Retrieves activity records for a specific date.

- **Parameters:**  
  - `activityDate` (string, format: `yyyy-MM-dd`)
- **Response:** `200 OK` with activity records for the date.
- **Error:**  
  - `400 Bad Request` if the date format is invalid.  
  - `500 Internal Server Error` on failure.

### `GET /healthz/liveness`

Health check endpoint for monitoring service liveness.

## Configuration

The API uses the following configuration sources:

- **Azure App Configuration** (`AzureAppConfigEndpoint`)
- **Azure Cosmos DB** (`CosmosDbEndpoint`)
- **SQL Server** (`SqlConnectionString`)

These are typically provided via environment variables.

## Dependencies

- .NET 7.0 or later
- Azure.Identity
- Microsoft.Azure.Cosmos
- Microsoft.EntityFrameworkCore.SqlServer
- Swashbuckle.AspNetCore (Swagger)
- Microsoft.Extensions.Diagnostics.HealthChecks

## Running Locally

1. Set the required environment variables:
    - `AzureAppConfigEndpoint`
    - `CosmosDbEndpoint`
    - `SqlConnectionString`
2. Build and run the project:
    ```sh
    dotnet build
    dotnet run
    ```
3. Access Swagger UI at `https://localhost:{port}/swagger`.

## Project Structure

- `Controllers/ActivityController.cs` - Main API controller for activity endpoints.
- `Services/` - Business logic and service interfaces.
- `Repository/` - Data access logic for SQL and Cosmos DB.
- `Common/` - Shared models and configuration.

## License

This project is licensed under the [Apache License 2.0](../../LICENSE).

---

For more details, see [Program.cs](src/Healthtrackr.Api.Activity/Healthtrackr.Api.Activity/Program.cs) and [ActivityController.cs](src/Healthtrackr.Api.Activity/Healthtrackr.Api.Activity/Controllers/ActivityController.cs).
## Current Services

| Project | Deployment Status | Code Coverage |
| ------- | ----------------- | ------------- |
| Healthtrackr.Activity | [![Healthtrackr.Activity](https://github.com/willvelida/healthtrackr/actions/workflows/deploy-activity.yml/badge.svg)](https://github.com/willvelida/healthtrackr/actions/workflows/deploy-activity.yml) | ![Code Coverage](https://img.shields.io/badge/Code%20Coverage-84%25-success?style=flat) |
| Healthtrackr.Api.Activity | [![Healthtrackr.Api.Activity](https://github.com/willvelida/healthtrackr/actions/workflows/deploy-api-activity.yml/badge.svg)](https://github.com/willvelida/healthtrackr/actions/workflows/deploy-api-activity.yml) | ![Code Coverage](https://img.shields.io/badge/Code%20Coverage-29%25-critical?style=flat) |
| Healthtrackr.Auth | [![HealthCheckr.Auth](https://github.com/willvelida/healthtrackr/actions/workflows/deploy-auth.yml/badge.svg)](https://github.com/willvelida/healthtrackr/actions/workflows/deploy-auth.yml) | ![Code Coverage](https://img.shields.io/badge/Code%20Coverage-71%25-yellow?style=flat) |
