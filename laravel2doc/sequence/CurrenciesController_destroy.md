sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant CurrenciesController as CurrenciesController
    participant Model as Model
    participant DB as Database
    
    C->>R: DELETE /resource/{id}
    R->>+CurrenciesController: destroy(id)
    CurrenciesController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-CurrenciesController: Model instance
    CurrenciesController->>+Model: delete()
    Model->>+DB: DELETE FROM table WHERE id = ?
    DB-->>-Model: Success
    Model-->>-CurrenciesController: Success
    CurrenciesController-->>-R: Return JSON response
    R-->>C: 204 No Content
    
    Note over CurrenciesController,Model: This sequence removes a resource
  