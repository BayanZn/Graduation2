sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant RolesController as RolesController
    participant V as Validator
    participant Model as Model
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+RolesController: update(request, id)
    RolesController->>+V: validate(request)
    V-->>-RolesController: validated data
    RolesController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-RolesController: Model instance
    RolesController->>+Model: update(data)
    Model->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-Model: Success
    Model-->>-RolesController: Updated model
    RolesController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over RolesController,Model: This sequence updates an existing resource
  