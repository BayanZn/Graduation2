sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant SettingsController as SettingsController
    participant V as Validator
    participant Currency as Currency
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+SettingsController: edit(request, id)
    SettingsController->>+V: validate(request)
    V-->>-SettingsController: validated data
    SettingsController->>+Currency: find(id)
    Currency->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Currency: Return record
    Currency-->>-SettingsController: Model instance
    SettingsController->>+Currency: update(data)
    Currency->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-Currency: Success
    Currency-->>-SettingsController: Updated model
    SettingsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over SettingsController,Currency: This sequence updates an existing resource
  