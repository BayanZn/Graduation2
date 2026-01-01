sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant PaymentMethodsController as PaymentMethodsController
    participant PaymentMethod as PaymentMethod
    participant DB as Database
    
    C->>R: GET /resource
    R->>+PaymentMethodsController: index()
    PaymentMethodsController->>+PaymentMethod: all() / get() / paginate()
    PaymentMethod->>+DB: SELECT * FROM table
    DB-->>-PaymentMethod: Return records
    PaymentMethod-->>-PaymentMethodsController: Collection of models
    PaymentMethodsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over PaymentMethodsController,PaymentMethod: This sequence retrieves a list of resources
  