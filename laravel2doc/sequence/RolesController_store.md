sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant RolesController as RolesController
    participant V as Validator
    participant Model as Model
    participant DB as Database
    
    C->>R: POST /resource
    R->>+RolesController: store(request)
    RolesController->>+V: validate(request)
    V-->>-RolesController: validated data
    RolesController->>+Model: create(data)
    Model->>+DB: INSERT INTO table
    DB-->>-Model: Return new record
    Model-->>-RolesController: New model instance
    RolesController-->>-R: Return JSON response
    R-->>C: 201 Created with data
    
    Note over RolesController,Model: This sequence creates a new resource
  