sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DashboardController as DashboardController
    participant Defense as Defense
    participant DB as Database
    
    C->>R: Request
    R->>+DashboardController: dashboard()
    Note over DashboardController: Process request
    alt Uses database
      DashboardController->>+Defense: operation()
      Defense->>+DB: Database query
      DB-->>-Defense: Return data
      Defense-->>-DashboardController: Return result
    else Direct response
      Note over DashboardController: Process without database
    end
    DashboardController-->>-R: Return response
    R-->>C: Response
    
    Note over DashboardController: Generic operation flow
  