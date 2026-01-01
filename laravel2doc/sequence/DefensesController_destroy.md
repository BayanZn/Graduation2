sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DefensesController as DefensesController
    participant Model as Model
    participant DB as Database
    
    C->>R: DELETE /resource/{id}
    R->>+DefensesController: destroy(id)
    DefensesController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-DefensesController: Model instance
    DefensesController->>+Model: delete()
    Model->>+DB: DELETE FROM table WHERE id = ?
    DB-->>-Model: Success
    Model-->>-DefensesController: Success
    DefensesController-->>-R: Return JSON response
    R-->>C: 204 No Content
    
    Note over DefensesController,Model: This sequence removes a resource
  