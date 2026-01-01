sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant MessagesController as MessagesController
    participant Model as Model
    participant DB as Database
    
    C->>R: Request
    R->>+MessagesController: loadMore()
    Note over MessagesController: Process request
    alt Uses database
      MessagesController->>+Model: operation()
      Model->>+DB: Database query
      DB-->>-Model: Return data
      Model-->>-MessagesController: Return result
    else Direct response
      Note over MessagesController: Process without database
    end
    MessagesController-->>-R: Return response
    R-->>C: Response
    
    Note over MessagesController: Generic operation flow
  