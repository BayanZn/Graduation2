sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DepartmentsController as DepartmentsController
    participant V as Validator
    participant Department as Department
    participant DB as Database
    
    C->>R: POST /resource
    R->>+DepartmentsController: store(request)
    DepartmentsController->>+V: validate(request)
    V-->>-DepartmentsController: validated data
    DepartmentsController->>+Department: create(data)
    Department->>+DB: INSERT INTO table
    DB-->>-Department: Return new record
    Department-->>-DepartmentsController: New model instance
    DepartmentsController-->>-R: Return JSON response
    R-->>C: 201 Created with data
    
    Note over DepartmentsController,Department: This sequence creates a new resource
  