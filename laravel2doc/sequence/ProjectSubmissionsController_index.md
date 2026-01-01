sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectSubmissionsController as ProjectSubmissionsController
    participant Project as Project
    participant DB as Database
    
    C->>R: GET /resource
    R->>+ProjectSubmissionsController: index()
    ProjectSubmissionsController->>+Project: all() / get() / paginate()
    Project->>+DB: SELECT * FROM table
    DB-->>-Project: Return records
    Project-->>-ProjectSubmissionsController: Collection of models
    ProjectSubmissionsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over ProjectSubmissionsController,Project: This sequence retrieves a list of resources
  