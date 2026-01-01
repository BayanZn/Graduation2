sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectSubmissionsController as ProjectSubmissionsController
    participant Project as Project
    participant DB as Database
    
    C->>R: GET /resource/{id}
    R->>+ProjectSubmissionsController: show(id)
    ProjectSubmissionsController->>+Project: find(id) / findOrFail(id)
    Project->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Project: Return record
    Project-->>-ProjectSubmissionsController: Model instance
    ProjectSubmissionsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over ProjectSubmissionsController,Project: This sequence retrieves a specific resource by ID
  