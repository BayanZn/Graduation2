sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ActivityLogsController as ActivityLogsController
    participant Model as Model
    participant DB as Database
    
    C->>R: Request
    R->>+ActivityLogsController: destroyMultiple()
    Note over ActivityLogsController: Process request
    alt Uses database
      ActivityLogsController->>+Model: operation()
      Model->>+DB: Database query
      DB-->>-Model: Return data
      Model-->>-ActivityLogsController: Return result
    else Direct response
      Note over ActivityLogsController: Process without database
    end
    ActivityLogsController-->>-R: Return response
    R-->>C: Response
    
    Note over ActivityLogsController: Generic operation flow
  