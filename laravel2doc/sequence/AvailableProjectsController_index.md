sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant AvailableProjectsController as AvailableProjectsController
    participant Project as Project
    participant DB as Database
    
    C->>R: GET /resource
    R->>+AvailableProjectsController: index()
    AvailableProjectsController->>+Project: all() / get() / paginate()
    Project->>+DB: SELECT * FROM table
    DB-->>-Project: Return records
    Project-->>-AvailableProjectsController: Collection of models
    AvailableProjectsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over AvailableProjectsController,Project: This sequence retrieves a list of resources
  