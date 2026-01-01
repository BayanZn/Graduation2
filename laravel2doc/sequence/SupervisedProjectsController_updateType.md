sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant SupervisedProjectsController as SupervisedProjectsController
    participant Model as Model
    participant DB as Database
    
    C->>R: Request
    R->>+SupervisedProjectsController: updateType()
    Note over SupervisedProjectsController: Process request
    alt Uses database
      SupervisedProjectsController->>+Model: operation()
      Model->>+DB: Database query
      DB-->>-Model: Return data
      Model-->>-SupervisedProjectsController: Return result
    else Direct response
      Note over SupervisedProjectsController: Process without database
    end
    SupervisedProjectsController-->>-R: Return response
    R-->>C: Response
    
    Note over SupervisedProjectsController: Generic operation flow
  