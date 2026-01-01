sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant AssignmentsController as AssignmentsController
    participant V as Validator
    participant Project as Project
    participant DB as Database
    
    C->>R: POST /resource
    R->>+AssignmentsController: create(request)
    AssignmentsController->>+V: validate(request)
    V-->>-AssignmentsController: validated data
    AssignmentsController->>+Project: create(data)
    Project->>+DB: INSERT INTO table
    DB-->>-Project: Return new record
    Project-->>-AssignmentsController: New model instance
    AssignmentsController-->>-R: Return JSON response
    R-->>C: 201 Created with data
    
    Note over AssignmentsController,Project: This sequence creates a new resource
  