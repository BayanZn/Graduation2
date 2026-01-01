sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DepartmentsController as DepartmentsController
    participant Model as Model
    participant DB as Database
    
    C->>R: DELETE /resource/{id}
    R->>+DepartmentsController: destroy(id)
    DepartmentsController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-DepartmentsController: Model instance
    DepartmentsController->>+Model: delete()
    Model->>+DB: DELETE FROM table WHERE id = ?
    DB-->>-Model: Success
    Model-->>-DepartmentsController: Success
    DepartmentsController-->>-R: Return JSON response
    R-->>C: 204 No Content
    
    Note over DepartmentsController,Model: This sequence removes a resource
  