# Batch integration testing

- Test every batch entrypoint.
- Execute the batch through its real application entrypoint while replacing external systems with isolated test boundaries.
- Exercise every possible batch argument combination and execution path.
- Put all paths for one batch entrypoint in one test file.

```text
/src
|-- [ApplicationName].sln
`-- [ApplicationName].Batchs.[BatchName].IntegrationTests/
    |-- [ApplicationName].Batchs.[BatchName].IntegrationTests.csproj
    |-- Controller1_Endpoint1_IntegrationTests.cs
    |-- Controller1_Endpoint2_IntegrationTests.cs
    `-- Controller2_Endpoint1_IntegrationTests.cs
```