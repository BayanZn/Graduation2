sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant UploadsController as UploadsController
    participant Model as Model
    participant DB as Database
    
    C->>R: Request
    R->>+UploadsController: filepondRemove()
    Note over UploadsController: Process request
    alt Uses database
      UploadsController->>+Model: operation()
      Model->>+DB: Database query
      DB-->>-Model: Return data
      Model-->>-UploadsController: Return result
    else Direct response
      Note over UploadsController: Process without database
    end
    UploadsController-->>-R: Return response
    R-->>C: Response
    
    Note over UploadsController: Generic operation flow
  