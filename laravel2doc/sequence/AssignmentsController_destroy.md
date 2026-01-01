sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant AssignmentsController as AssignmentsController
    participant Model as Model
    participant DB as Database
    
    C->>R: DELETE /resource/{id}
    R->>+AssignmentsController: destroy(id)
    AssignmentsController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-AssignmentsController: Model instance
    AssignmentsController->>+Model: delete()
    Model->>+DB: DELETE FROM table WHERE id = ?
    DB-->>-Model: Success
    Model-->>-AssignmentsController: Success
    AssignmentsController-->>-R: Return JSON response
    R-->>C: 204 No Content
    
    Note over AssignmentsController,Model: This sequence removes a resource
  