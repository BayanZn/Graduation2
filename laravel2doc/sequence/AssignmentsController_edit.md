sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant AssignmentsController as AssignmentsController
    participant V as Validator
    participant Project as Project
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+AssignmentsController: edit(request, id)
    AssignmentsController->>+V: validate(request)
    V-->>-AssignmentsController: validated data
    AssignmentsController->>+Project: find(id)
    Project->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Project: Return record
    Project-->>-AssignmentsController: Model instance
    AssignmentsController->>+Project: update(data)
    Project->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-Project: Success
    Project-->>-AssignmentsController: Updated model
    AssignmentsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over AssignmentsController,Project: This sequence updates an existing resource
  