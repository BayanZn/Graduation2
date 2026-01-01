sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DefensesController as DefensesController
    participant V as Validator
    participant User as User
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+DefensesController: edit(request, id)
    DefensesController->>+V: validate(request)
    V-->>-DefensesController: validated data
    DefensesController->>+User: find(id)
    User->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-User: Return record
    User-->>-DefensesController: Model instance
    DefensesController->>+User: update(data)
    User->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-User: Success
    User-->>-DefensesController: Updated model
    DefensesController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over DefensesController,User: This sequence updates an existing resource
  