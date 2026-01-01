sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DefensesController as DefensesController
    participant Defense as Defense
    participant DB as Database
    
    C->>R: GET /resource/{id}
    R->>+DefensesController: show(id)
    DefensesController->>+Defense: find(id) / findOrFail(id)
    Defense->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Defense: Return record
    Defense-->>-DefensesController: Model instance
    DefensesController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over DefensesController,Defense: This sequence retrieves a specific resource by ID
  