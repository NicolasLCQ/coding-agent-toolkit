# API integration testing

- Test every API endpoint.
- Use `WebApplicationFactory` to host the API under test.
- Exercise every possible endpoint argument combination and response path through the hosted application.
- Put all paths for one endpoint in one test file.
- Name endpoint test files `Controller_Endpoint_IntegrationTests.cs`; for example, use `User_CreateUser_IntegrationTests.cs` for `UserController.CreateUser`.

```text
/src
|-- [ApplicationName].sln
`-- [ApplicationName].IntegrationTests/
    |-- [ApplicationName].IntegrationTests.csproj
    |-- Controller1_Endpoint1_IntegrationTests.cs
    |-- Controller1_Endpoint2_IntegrationTests.cs
    `-- Controller2_Endpoint1_IntegrationTests.cs
```

