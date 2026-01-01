sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectSubmissionsController as ProjectSubmissionsController
    participant Project as Project
    participant DB as Database
    
    C->>R: Request
    R->>+ProjectSubmissionsController: updateStatus()
    Note over ProjectSubmissionsController: Process request
    alt Uses database
      ProjectSubmissionsController->>+Project: operation()
      Project->>+DB: Database query
      DB-->>-Project: Return data
      Project-->>-ProjectSubmissionsController: Return result
    else Direct response
      Note over ProjectSubmissionsController: Process without database
    end
    ProjectSubmissionsController-->>-R: Return response
    R-->>C: Response
    
    Note over ProjectSubmissionsController: Generic operation flow
  