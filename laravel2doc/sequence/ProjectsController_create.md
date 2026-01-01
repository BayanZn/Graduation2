sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectsController as ProjectsController
    participant V as Validator
    participant Department as Department
    participant DB as Database
    
    C->>R: POST /resource
    R->>+ProjectsController: create(request)
    ProjectsController->>+V: validate(request)
    V-->>-ProjectsController: validated data
    ProjectsController->>+Department: create(data)
    Department->>+DB: INSERT INTO table
    DB-->>-Department: Return new record
    Department-->>-ProjectsController: New model instance
    ProjectsController-->>-R: Return JSON response
    R-->>C: 201 Created with data
    
    Note over ProjectsController,Department: This sequence creates a new resource
  