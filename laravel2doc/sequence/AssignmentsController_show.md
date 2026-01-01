sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant AssignmentsController as AssignmentsController
    participant Model as Model
    participant DB as Database
    
    C->>R: GET /resource/{id}
    R->>+AssignmentsController: show(id)
    AssignmentsController->>+Model: find(id) / findOrFail(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-AssignmentsController: Model instance
    AssignmentsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over AssignmentsController,Model: This sequence retrieves a specific resource by ID
  