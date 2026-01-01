sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DefensesController as DefensesController
    participant Model as Model
    participant DB as Database
    
    C->>R: Request
    R->>+DefensesController: removeMember()
    Note over DefensesController: Process request
    alt Uses database
      DefensesController->>+Model: operation()
      Model->>+DB: Database query
      DB-->>-Model: Return data
      Model-->>-DefensesController: Return result
    else Direct response
      Note over DefensesController: Process without database
    end
    DefensesController-->>-R: Return response
    R-->>C: Response
    
    Note over DefensesController: Generic operation flow
  