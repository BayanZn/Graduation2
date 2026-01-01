sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant AssignmentsController as AssignmentsController
    participant Project as Project
    participant DB as Database
    
    C->>R: GET /resource
    R->>+AssignmentsController: index()
    AssignmentsController->>+Project: all() / get() / paginate()
    Project->>+DB: SELECT * FROM table
    DB-->>-Project: Return records
    Project-->>-AssignmentsController: Collection of models
    AssignmentsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over AssignmentsController,Project: This sequence retrieves a list of resources
  