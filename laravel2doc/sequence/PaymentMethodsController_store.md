sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant PaymentMethodsController as PaymentMethodsController
    participant V as Validator
    participant PaymentMethod as PaymentMethod
    participant DB as Database
    
    C->>R: POST /resource
    R->>+PaymentMethodsController: store(request)
    PaymentMethodsController->>+V: validate(request)
    V-->>-PaymentMethodsController: validated data
    PaymentMethodsController->>+PaymentMethod: create(data)
    PaymentMethod->>+DB: INSERT INTO table
    DB-->>-PaymentMethod: Return new record
    PaymentMethod-->>-PaymentMethodsController: New model instance
    PaymentMethodsController-->>-R: Return JSON response
    R-->>C: 201 Created with data
    
    Note over PaymentMethodsController,PaymentMethod: This sequence creates a new resource
  