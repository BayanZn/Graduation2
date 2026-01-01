sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant RolesController as RolesController
    participant Model as Model
    participant DB as Database
    
    C->>R: DELETE /resource/{id}
    R->>+RolesController: destroy(id)
    RolesController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-RolesController: Model instance
    RolesController->>+Model: delete()
    Model->>+DB: DELETE FROM table WHERE id = ?
    DB-->>-Model: Success
    Model-->>-RolesController: Success
    RolesController-->>-R: Return JSON response
    R-->>C: 204 No Content
    
    Note over RolesController,Model: This sequence removes a resource
  