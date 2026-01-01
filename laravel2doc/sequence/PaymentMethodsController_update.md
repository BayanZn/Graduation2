sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant PaymentMethodsController as PaymentMethodsController
    participant V as Validator
    participant Model as Model
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+PaymentMethodsController: update(request, id)
    PaymentMethodsController->>+V: validate(request)
    V-->>-PaymentMethodsController: validated data
    PaymentMethodsController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-PaymentMethodsController: Model instance
    PaymentMethodsController->>+Model: update(data)
    Model->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-Model: Success
    Model-->>-PaymentMethodsController: Updated model
    PaymentMethodsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over PaymentMethodsController,Model: This sequence updates an existing resource
  