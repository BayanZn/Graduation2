sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant UsersController as UsersController
    participant V as Validator
    participant Model as Model
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+UsersController: update(request, id)
    UsersController->>+V: validate(request)
    V-->>-UsersController: validated data
    UsersController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-UsersController: Model instance
    UsersController->>+Model: update(data)
    Model->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-Model: Success
    Model-->>-UsersController: Updated model
    UsersController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over UsersController,Model: This sequence updates an existing resource
  