sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectRequestsController as ProjectRequestsController
    participant Project as Project
    participant DB as Database
    
    C->>R: GET /resource
    R->>+ProjectRequestsController: index()
    ProjectRequestsController->>+Project: all() / get() / paginate()
    Project->>+DB: SELECT * FROM table
    DB-->>-Project: Return records
    Project-->>-ProjectRequestsController: Collection of models
    ProjectRequestsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over ProjectRequestsController,Project: This sequence retrieves a list of resources
  