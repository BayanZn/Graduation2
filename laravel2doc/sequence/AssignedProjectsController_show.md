sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant AssignedProjectsController as AssignedProjectsController
    participant Model as Model
    participant DB as Database
    
    C->>R: GET /resource/{id}
    R->>+AssignedProjectsController: show(id)
    AssignedProjectsController->>+Model: find(id) / findOrFail(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-AssignedProjectsController: Model instance
    AssignedProjectsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over AssignedProjectsController,Model: This sequence retrieves a specific resource by ID
  