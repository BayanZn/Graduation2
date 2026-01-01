sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DepartmentsController as DepartmentsController
    participant V as Validator
    participant Department as Department
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+DepartmentsController: edit(request, id)
    DepartmentsController->>+V: validate(request)
    V-->>-DepartmentsController: validated data
    DepartmentsController->>+Department: find(id)
    Department->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Department: Return record
    Department-->>-DepartmentsController: Model instance
    DepartmentsController->>+Department: update(data)
    Department->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-Department: Success
    Department-->>-DepartmentsController: Updated model
    DepartmentsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over DepartmentsController,Department: This sequence updates an existing resource
  