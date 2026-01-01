sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant UsersController as UsersController
    participant Model as Model
    participant DB as Database
    
    C->>R: DELETE /resource/{id}
    R->>+UsersController: destroy(id)
    UsersController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-UsersController: Model instance
    UsersController->>+Model: delete()
    Model->>+DB: DELETE FROM table WHERE id = ?
    DB-->>-Model: Success
    Model-->>-UsersController: Success
    UsersController-->>-R: Return JSON response
    R-->>C: 204 No Content
    
    Note over UsersController,Model: This sequence removes a resource
  