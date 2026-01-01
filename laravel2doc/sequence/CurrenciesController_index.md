sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant CurrenciesController as CurrenciesController
    participant Currency as Currency
    participant DB as Database
    
    C->>R: GET /resource
    R->>+CurrenciesController: index()
    CurrenciesController->>+Currency: all() / get() / paginate()
    Currency->>+DB: SELECT * FROM table
    DB-->>-Currency: Return records
    Currency-->>-CurrenciesController: Collection of models
    CurrenciesController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over CurrenciesController,Currency: This sequence retrieves a list of resources
  