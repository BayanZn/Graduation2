sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant AvailableProjectsController as AvailableProjectsController
    participant Model as Model
    participant DB as Database
    
    C->>R: GET /resource/{id}
    R->>+AvailableProjectsController: show(id)
    AvailableProjectsController->>+Model: find(id) / findOrFail(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-AvailableProjectsController: Model instance
    AvailableProjectsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over AvailableProjectsController,Model: This sequence retrieves a specific resource by ID
  