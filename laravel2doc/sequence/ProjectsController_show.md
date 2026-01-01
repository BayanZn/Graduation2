sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectsController as ProjectsController
    participant Model as Model
    participant DB as Database
    
    C->>R: GET /resource/{id}
    R->>+ProjectsController: show(id)
    ProjectsController->>+Model: find(id) / findOrFail(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-ProjectsController: Model instance
    ProjectsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over ProjectsController,Model: This sequence retrieves a specific resource by ID
  