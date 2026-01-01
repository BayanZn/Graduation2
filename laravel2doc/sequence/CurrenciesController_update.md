sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant CurrenciesController as CurrenciesController
    participant V as Validator
    participant Model as Model
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+CurrenciesController: update(request, id)
    CurrenciesController->>+V: validate(request)
    V-->>-CurrenciesController: validated data
    CurrenciesController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-CurrenciesController: Model instance
    CurrenciesController->>+Model: update(data)
    Model->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-Model: Success
    Model-->>-CurrenciesController: Updated model
    CurrenciesController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over CurrenciesController,Model: This sequence updates an existing resource
  