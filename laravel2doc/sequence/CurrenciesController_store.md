sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant CurrenciesController as CurrenciesController
    participant V as Validator
    participant Currency as Currency
    participant DB as Database
    
    C->>R: POST /resource
    R->>+CurrenciesController: store(request)
    CurrenciesController->>+V: validate(request)
    V-->>-CurrenciesController: validated data
    CurrenciesController->>+Currency: create(data)
    Currency->>+DB: INSERT INTO table
    DB-->>-Currency: Return new record
    Currency-->>-CurrenciesController: New model instance
    CurrenciesController-->>-R: Return JSON response
    R-->>C: 201 Created with data
    
    Note over CurrenciesController,Currency: This sequence creates a new resource
  