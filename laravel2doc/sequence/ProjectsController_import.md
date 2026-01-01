sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectsController as ProjectsController
    participant Message as Message
    participant DB as Database
    
    C->>R: Request
    R->>+ProjectsController: import()
    Note over ProjectsController: Process request
    alt Uses database
      ProjectsController->>+Message: operation()
      Message->>+DB: Database query
      DB-->>-Message: Return data
      Message-->>-ProjectsController: Return result
    else Direct response
      Note over ProjectsController: Process without database
    end
    ProjectsController-->>-R: Return response
    R-->>C: Response
    
    Note over ProjectsController: Generic operation flow
  