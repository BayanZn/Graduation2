sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectsController as ProjectsController
    participant Model as Model
    participant DB as Database
    
    C->>R: Request
    R->>+ProjectsController: updateType()
    Note over ProjectsController: Process request
    alt Uses database
      ProjectsController->>+Model: operation()
      Model->>+DB: Database query
      DB-->>-Model: Return data
      Model-->>-ProjectsController: Return result
    else Direct response
      Note over ProjectsController: Process without database
    end
    ProjectsController-->>-R: Return response
    R-->>C: Response
    
    Note over ProjectsController: Generic operation flow
  