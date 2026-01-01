sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant SupervisedProjectsController as SupervisedProjectsController
    participant Project as Project
    participant DB as Database
    
    C->>R: GET /resource/{id}
    R->>+SupervisedProjectsController: show(id)
    SupervisedProjectsController->>+Project: find(id) / findOrFail(id)
    Project->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Project: Return record
    Project-->>-SupervisedProjectsController: Model instance
    SupervisedProjectsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over SupervisedProjectsController,Project: This sequence retrieves a specific resource by ID
  