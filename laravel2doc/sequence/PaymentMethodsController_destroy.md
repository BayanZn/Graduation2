sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant PaymentMethodsController as PaymentMethodsController
    participant Model as Model
    participant DB as Database
    
    C->>R: DELETE /resource/{id}
    R->>+PaymentMethodsController: destroy(id)
    PaymentMethodsController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-PaymentMethodsController: Model instance
    PaymentMethodsController->>+Model: delete()
    Model->>+DB: DELETE FROM table WHERE id = ?
    DB-->>-Model: Success
    Model-->>-PaymentMethodsController: Success
    PaymentMethodsController-->>-R: Return JSON response
    R-->>C: 204 No Content
    
    Note over PaymentMethodsController,Model: This sequence removes a resource
  