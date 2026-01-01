sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectRequestsController as ProjectRequestsController
    participant Model as Model
    participant DB as Database
    
    C->>R: Request
    R->>+ProjectRequestsController: resetToPending()
    Note over ProjectRequestsController: Process request
    alt Uses database
      ProjectRequestsController->>+Model: operation()
      Model->>+DB: Database query
      DB-->>-Model: Return data
      Model-->>-ProjectRequestsController: Return result
    else Direct response
      Note over ProjectRequestsController: Process without database
    end
    ProjectRequestsController-->>-R: Return response
    R-->>C: Response
    
    Note over ProjectRequestsController: Generic operation flow
  