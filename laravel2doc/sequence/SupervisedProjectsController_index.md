sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant SupervisedProjectsController as SupervisedProjectsController
    participant Project as Project
    participant DB as Database
    
    C->>R: GET /resource
    R->>+SupervisedProjectsController: index()
    SupervisedProjectsController->>+Project: all() / get() / paginate()
    Project->>+DB: SELECT * FROM table
    DB-->>-Project: Return records
    Project-->>-SupervisedProjectsController: Collection of models
    SupervisedProjectsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over SupervisedProjectsController,Project: This sequence retrieves a list of resources
  