sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ProjectSubmissionsController as ProjectSubmissionsController
    participant V as Validator
    participant Project as Project
    participant DB as Database
    
    C->>R: POST /resource
    R->>+ProjectSubmissionsController: store(request)
    ProjectSubmissionsController->>+V: validate(request)
    V-->>-ProjectSubmissionsController: validated data
    ProjectSubmissionsController->>+Project: create(data)
    Project->>+DB: INSERT INTO table
    DB-->>-Project: Return new record
    Project-->>-ProjectSubmissionsController: New model instance
    ProjectSubmissionsController-->>-R: Return JSON response
    R-->>C: 201 Created with data
    
    Note over ProjectSubmissionsController,Project: This sequence creates a new resource
  