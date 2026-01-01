sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant PaymentMethodsController as PaymentMethodsController
    participant V as Validator
    participant PaymentMethod as PaymentMethod
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+PaymentMethodsController: edit(request, id)
    PaymentMethodsController->>+V: validate(request)
    V-->>-PaymentMethodsController: validated data
    PaymentMethodsController->>+PaymentMethod: find(id)
    PaymentMethod->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-PaymentMethod: Return record
    PaymentMethod-->>-PaymentMethodsController: Model instance
    PaymentMethodsController->>+PaymentMethod: update(data)
    PaymentMethod->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-PaymentMethod: Success
    PaymentMethod-->>-PaymentMethodsController: Updated model
    PaymentMethodsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over PaymentMethodsController,PaymentMethod: This sequence updates an existing resource
  