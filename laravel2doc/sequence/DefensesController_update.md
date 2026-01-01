sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DefensesController as DefensesController
    participant V as Validator
    participant Model as Model
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+DefensesController: update(request, id)
    DefensesController->>+V: validate(request)
    V-->>-DefensesController: validated data
    DefensesController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-DefensesController: Model instance
    DefensesController->>+Model: update(data)
    Model->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-Model: Success
    Model-->>-DefensesController: Updated model
    DefensesController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over DefensesController,Model: This sequence updates an existing resource
  