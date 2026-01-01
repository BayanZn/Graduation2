sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant RolesController as RolesController
    participant Model as Model
    participant DB as Database
    
    C->>R: GET /resource
    R->>+RolesController: index()
    RolesController->>+Model: all() / get() / paginate()
    Model->>+DB: SELECT * FROM table
    DB-->>-Model: Return records
    Model-->>-RolesController: Collection of models
    RolesController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over RolesController,Model: This sequence retrieves a list of resources
  