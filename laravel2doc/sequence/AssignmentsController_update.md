sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant AssignmentsController as AssignmentsController
    participant V as Validator
    participant Model as Model
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+AssignmentsController: update(request, id)
    AssignmentsController->>+V: validate(request)
    V-->>-AssignmentsController: validated data
    AssignmentsController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-AssignmentsController: Model instance
    AssignmentsController->>+Model: update(data)
    Model->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-Model: Success
    Model-->>-AssignmentsController: Updated model
    AssignmentsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over AssignmentsController,Model: This sequence updates an existing resource
  