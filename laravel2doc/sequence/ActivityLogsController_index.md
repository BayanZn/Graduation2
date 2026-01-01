sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ActivityLogsController as ActivityLogsController
    participant Model as Model
    participant DB as Database
    
    C->>R: GET /resource
    R->>+ActivityLogsController: index()
    ActivityLogsController->>+Model: all() / get() / paginate()
    Model->>+DB: SELECT * FROM table
    DB-->>-Model: Return records
    Model-->>-ActivityLogsController: Collection of models
    ActivityLogsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over ActivityLogsController,Model: This sequence retrieves a list of resources
  