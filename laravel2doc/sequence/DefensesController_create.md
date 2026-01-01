sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DefensesController as DefensesController
    participant V as Validator
    participant Project as Project
    participant DB as Database
    
    C->>R: POST /resource
    R->>+DefensesController: create(request)
    DefensesController->>+V: validate(request)
    V-->>-DefensesController: validated data
    DefensesController->>+Project: create(data)
    Project->>+DB: INSERT INTO table
    DB-->>-Project: Return new record
    Project-->>-DefensesController: New model instance
    DefensesController-->>-R: Return JSON response
    R-->>C: 201 Created with data
    
    Note over DefensesController,Project: This sequence creates a new resource
  