sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectRequestsController as ProjectRequestsController
    participant User as User
    participant DB as Database
    
    C->>R: GET /resource/{id}
    R->>+ProjectRequestsController: show(id)
    ProjectRequestsController->>+User: find(id) / findOrFail(id)
    User->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-User: Return record
    User-->>-ProjectRequestsController: Model instance
    ProjectRequestsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over ProjectRequestsController,User: This sequence retrieves a specific resource by ID
  