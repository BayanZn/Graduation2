sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant RolesController as RolesController
    participant V as Validator
    participant User as User
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+RolesController: edit(request, id)
    RolesController->>+V: validate(request)
    V-->>-RolesController: validated data
    RolesController->>+User: find(id)
    User->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-User: Return record
    User-->>-RolesController: Model instance
    RolesController->>+User: update(data)
    User->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-User: Success
    User-->>-RolesController: Updated model
    RolesController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over RolesController,User: This sequence updates an existing resource
  