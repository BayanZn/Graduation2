sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectsController as ProjectsController
    participant V as Validator
    participant Project as Project
    participant DB as Database
    
    C->>R: POST /resource
    R->>+ProjectsController: store(request)
    ProjectsController->>+V: validate(request)
    V-->>-ProjectsController: validated data
    ProjectsController->>+Project: create(data)
    Project->>+DB: INSERT INTO table
    DB-->>-Project: Return new record
    Project-->>-ProjectsController: New model instance
    ProjectsController-->>-R: Return JSON response
    R-->>C: 201 Created with data
    
    Note over ProjectsController,Project: This sequence creates a new resource
  