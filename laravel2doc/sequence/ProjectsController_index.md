sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectsController as ProjectsController
    participant Project as Project
    participant DB as Database
    
    C->>R: GET /resource
    R->>+ProjectsController: index()
    ProjectsController->>+Project: all() / get() / paginate()
    Project->>+DB: SELECT * FROM table
    DB-->>-Project: Return records
    Project-->>-ProjectsController: Collection of models
    ProjectsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over ProjectsController,Project: This sequence retrieves a list of resources
  