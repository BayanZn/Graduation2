sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant StudentsController as StudentsController
    participant Project as Project
    participant DB as Database
    
    C->>R: GET /resource
    R->>+StudentsController: index()
    StudentsController->>+Project: all() / get() / paginate()
    Project->>+DB: SELECT * FROM table
    DB-->>-Project: Return records
    Project-->>-StudentsController: Collection of models
    StudentsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over StudentsController,Project: This sequence retrieves a list of resources
  