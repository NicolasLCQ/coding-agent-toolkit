# C# Clean Architecture reference

## Required layers

Structure the solution around three main layers: API, Application, and Gateway.

### API

The API layer is the application entry point. It exposes client endpoints, handles exceptions and errors at the transport boundary, and maps between API and Application models. Resources or controllers receive and validate requests, then delegate processing to Application.

Use these responsibilities and folders:

- `Resources/` or `Controllers/`: process incoming requests.
- `Routes/`: define paths to resources.
- `Models/`: define request and response models.
- `Extensions/`: define extension methods for models.
- `Helpers/`: provide common API-layer methods.
- `Mappers/`: convert between API and Application models.
- `Middleware/`: handle exceptions, errors, authentication, logging, and other request-pipeline concerns.
- `Validators/`: validate requests.
- `Program.cs`: compose and start the API.

### Application

The Application layer owns business logic. Use cases perform tasks, and interfaces provide the boundaries through which other layers expose services or implement access to external services. Application also generates business errors. It does not map between layers.

Use these responsibilities and folders:

- `UseCases/`: implement business logic, grouped by domain and use case.
- `Interfaces/`: define ports implemented by Gateway and interfaces through which Application exposes its own services.
- `Models/`: define business models.
- `Extensions/`: define extension methods for models.
- `Helpers/`: provide common Application-layer methods.

### Gateway

The Gateway layer communicates with external services, handles external errors, and maps between Gateway and Application models.

Use these responsibilities and folders:

- `WebServices/`: communicate with services accessible over the web.
- `Adapters/`: communicate with the operating system or other system facilities.
- `Models/`: define external-service models.
- `Mappers/`: convert between Gateway and Application models.
- `Extensions/`: define extension methods for models.
- `Helpers/`: provide common Gateway-layer methods.
- `Repositories/`: provide database access.

## Solution shape

```text
/src
|-- [ApplicationName].sln
|-- [ApplicationName].Api/
|   |-- [ApplicationName].Api.csproj
|   |-- Resources/ or Controllers/
|   |-- Routes/
|   |-- Models/
|   |-- Extensions/
|   |-- Helpers/
|   |-- Mappers/
|   |-- Middleware/
|   |-- Validators/
|   `-- Program.cs
|-- [ApplicationName].Application/
|   |-- [ApplicationName].Application.csproj
|   |-- Extensions/
|   |-- Helpers/
|   |-- Interfaces/
|   |-- Models/
|   `-- UseCases/
|       |-- Domain1.cs
|       |-- Domain1.UseCase1.cs
|       |-- Domain1.UseCase2.cs
|       |-- Domain2.cs
|       `-- Domain2.UseCase1.cs
`-- [ApplicationName].Gateway/
    |-- [ApplicationName].Gateway.csproj
    |-- WebServices/
    |-- Adapters/
    |-- Repositories/
    |-- Extensions/
    |-- Helpers/
    |-- Models/
    `-- Mappers/
```

Adapt capitalization and naming to the repository while preserving the responsibilities.

## Project references

The allowed project-reference direction is:

```text
[ApplicationName].Api -> [ApplicationName].Gateway -> [ApplicationName].Application
[ApplicationName].Api -----------------------------> [ApplicationName].Application
```

`[ApplicationName].Application.csproj` references no other solution project.

