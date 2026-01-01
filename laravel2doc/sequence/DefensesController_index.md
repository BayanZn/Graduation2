sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DefensesController as DefensesController
    participant Defense as Defense
    participant DB as Database
    
    C->>R: GET /resource
    R->>+DefensesController: index()
    DefensesController->>+Defense: all() / get() / paginate()
    Defense->>+DB: SELECT * FROM table
    DB-->>-Defense: Return records
    Defense-->>-DefensesController: Collection of models
    DefensesController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over DefensesController,Defense: This sequence retrieves a list of resources
  