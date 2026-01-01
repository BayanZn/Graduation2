sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant RolesController as RolesController
    participant V as Validator
    participant User as User
    participant DB as Database
    
    C->>R: POST /resource
    R->>+RolesController: create(request)
    RolesController->>+V: validate(request)
    V-->>-RolesController: validated data
    RolesController->>+User: create(data)
    User->>+DB: INSERT INTO table
    DB-->>-User: Return new record
    User-->>-RolesController: New model instance
    RolesController-->>-R: Return JSON response
    R-->>C: 201 Created with data
    
    Note over RolesController,User: This sequence creates a new resource
  