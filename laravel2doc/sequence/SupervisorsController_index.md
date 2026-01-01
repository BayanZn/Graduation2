sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant SupervisorsController as SupervisorsController
    participant User as User
    participant DB as Database
    
    C->>R: GET /resource
    R->>+SupervisorsController: index()
    SupervisorsController->>+User: all() / get() / paginate()
    User->>+DB: SELECT * FROM table
    DB-->>-User: Return records
    User-->>-SupervisorsController: Collection of models
    SupervisorsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over SupervisorsController,User: This sequence retrieves a list of resources
  