sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectsController as ProjectsController
    participant V as Validator
    participant Model as Model
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+ProjectsController: update(request, id)
    ProjectsController->>+V: validate(request)
    V-->>-ProjectsController: validated data
    ProjectsController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-ProjectsController: Model instance
    ProjectsController->>+Model: update(data)
    Model->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-Model: Success
    Model-->>-ProjectsController: Updated model
    ProjectsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over ProjectsController,Model: This sequence updates an existing resource
  