sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant UsersController as UsersController
    participant User as User
    participant DB as Database
    
    C->>R: GET /resource
    R->>+UsersController: index()
    UsersController->>+User: all() / get() / paginate()
    User->>+DB: SELECT * FROM table
    DB-->>-User: Return records
    User-->>-UsersController: Collection of models
    UsersController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over UsersController,User: This sequence retrieves a list of resources
  