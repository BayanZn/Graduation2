sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant UsersController as UsersController
    participant V as Validator
    participant User as User
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+UsersController: edit(request, id)
    UsersController->>+V: validate(request)
    V-->>-UsersController: validated data
    UsersController->>+User: find(id)
    User->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-User: Return record
    User-->>-UsersController: Model instance
    UsersController->>+User: update(data)
    User->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-User: Success
    User-->>-UsersController: Updated model
    UsersController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over UsersController,User: This sequence updates an existing resource
  