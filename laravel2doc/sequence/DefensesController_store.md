sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DefensesController as DefensesController
    participant V as Validator
    participant Defense as Defense
    participant DB as Database
    
    C->>R: POST /resource
    R->>+DefensesController: store(request)
    DefensesController->>+V: validate(request)
    V-->>-DefensesController: validated data
    DefensesController->>+Defense: create(data)
    Defense->>+DB: INSERT INTO table
    DB-->>-Defense: Return new record
    Defense-->>-DefensesController: New model instance
    DefensesController-->>-R: Return JSON response
    R-->>C: 201 Created with data
    
    Note over DefensesController,Defense: This sequence creates a new resource
  