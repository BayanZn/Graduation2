sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant AvailableProjectsController as AvailableProjectsController
    participant Project as Project
    participant DB as Database
    
    C->>R: Request
    R->>+AvailableProjectsController: requestProject()
    Note over AvailableProjectsController: Process request
    alt Uses database
      AvailableProjectsController->>+Project: operation()
      Project->>+DB: Database query
      DB-->>-Project: Return data
      Project-->>-AvailableProjectsController: Return result
    else Direct response
      Note over AvailableProjectsController: Process without database
    end
    AvailableProjectsController-->>-R: Return response
    R-->>C: Response
    
    Note over AvailableProjectsController: Generic operation flow
  