sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant AssignedProjectsController as AssignedProjectsController
    participant Project as Project
    participant DB as Database
    
    C->>R: GET /resource
    R->>+AssignedProjectsController: index()
    AssignedProjectsController->>+Project: all() / get() / paginate()
    Project->>+DB: SELECT * FROM table
    DB-->>-Project: Return records
    Project-->>-AssignedProjectsController: Collection of models
    AssignedProjectsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over AssignedProjectsController,Project: This sequence retrieves a list of resources
  