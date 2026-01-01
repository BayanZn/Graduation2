sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectsController as ProjectsController
    participant V as Validator
    participant Department as Department
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+ProjectsController: edit(request, id)
    ProjectsController->>+V: validate(request)
    V-->>-ProjectsController: validated data
    ProjectsController->>+Department: find(id)
    Department->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Department: Return record
    Department-->>-ProjectsController: Model instance
    ProjectsController->>+Department: update(data)
    Department->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-Department: Success
    Department-->>-ProjectsController: Updated model
    ProjectsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over ProjectsController,Department: This sequence updates an existing resource
  