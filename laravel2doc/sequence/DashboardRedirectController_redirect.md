sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DashboardRedirectController as DashboardRedirectController
    participant Model as Model
    participant DB as Database
    
    C->>R: Request
    R->>+DashboardRedirectController: redirect()
    Note over DashboardRedirectController: Process request
    alt Uses database
      DashboardRedirectController->>+Model: operation()
      Model->>+DB: Database query
      DB-->>-Model: Return data
      Model-->>-DashboardRedirectController: Return result
    else Direct response
      Note over DashboardRedirectController: Process without database
    end
    DashboardRedirectController-->>-R: Return response
    R-->>C: Response
    
    Note over DashboardRedirectController: Generic operation flow
  