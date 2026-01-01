sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant AssignmentsController as AssignmentsController
    participant Model as Model
    participant DB as Database
    
    C->>R: Request
    R->>+AssignmentsController: removeSupervisor()
    Note over AssignmentsController: Process request
    alt Uses database
      AssignmentsController->>+Model: operation()
      Model->>+DB: Database query
      DB-->>-Model: Return data
      Model-->>-AssignmentsController: Return result
    else Direct response
      Note over AssignmentsController: Process without database
    end
    AssignmentsController-->>-R: Return response
    R-->>C: Response
    
    Note over AssignmentsController: Generic operation flow
  