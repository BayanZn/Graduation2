sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DepartmentsController as DepartmentsController
    participant Department as Department
    participant DB as Database
    
    C->>R: GET /resource
    R->>+DepartmentsController: index()
    DepartmentsController->>+Department: all() / get() / paginate()
    Department->>+DB: SELECT * FROM table
    DB-->>-Department: Return records
    Department-->>-DepartmentsController: Collection of models
    DepartmentsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over DepartmentsController,Department: This sequence retrieves a list of resources
  