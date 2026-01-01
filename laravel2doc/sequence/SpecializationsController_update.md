sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant SpecializationsController as SpecializationsController
    participant V as Validator
    participant Model as Model
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+SpecializationsController: update(request, id)
    SpecializationsController->>+V: validate(request)
    V-->>-SpecializationsController: validated data
    SpecializationsController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-SpecializationsController: Model instance
    SpecializationsController->>+Model: update(data)
    Model->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-Model: Success
    Model-->>-SpecializationsController: Updated model
    SpecializationsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over SpecializationsController,Model: This sequence updates an existing resource
  