sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant UsersController as UsersController
    participant V as Validator
    participant User as User
    participant DB as Database
    
    C->>R: POST /resource
    R->>+UsersController: create(request)
    UsersController->>+V: validate(request)
    V-->>-UsersController: validated data
    UsersController->>+User: create(data)
    User->>+DB: INSERT INTO table
    DB-->>-User: Return new record
    User-->>-UsersController: New model instance
    UsersController-->>-R: Return JSON response
    R-->>C: 201 Created with data
    
    Note over UsersController,User: This sequence creates a new resource
  