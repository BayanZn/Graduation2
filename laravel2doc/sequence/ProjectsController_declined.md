sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectsController as ProjectsController
    participant Project as Project
    participant DB as Database
    
    C->>R: Request
    R->>+ProjectsController: declined()
    Note over ProjectsController: Process request
    alt Uses database
      ProjectsController->>+Project: operation()
      Project->>+DB: Database query
      DB-->>-Project: Return data
      Project-->>-ProjectsController: Return result
    else Direct response
      Note over ProjectsController: Process without database
    end
    ProjectsController-->>-R: Return response
    R-->>C: Response
    
    Note over ProjectsController: Generic operation flow
  