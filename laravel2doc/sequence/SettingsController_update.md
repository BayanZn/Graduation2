sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant SettingsController as SettingsController
    participant V as Validator
    participant Model as Model
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+SettingsController: update(request, id)
    SettingsController->>+V: validate(request)
    V-->>-SettingsController: validated data
    SettingsController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-SettingsController: Model instance
    SettingsController->>+Model: update(data)
    Model->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-Model: Success
    Model-->>-SettingsController: Updated model
    SettingsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over SettingsController,Model: This sequence updates an existing resource
  