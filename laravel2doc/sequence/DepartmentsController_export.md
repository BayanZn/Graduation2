sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant DepartmentsController as DepartmentsController
    participant Department as Department
    participant DB as Database
    
    C->>R: Request
    R->>+DepartmentsController: export()
    Note over DepartmentsController: Process request
    alt Uses database
      DepartmentsController->>+Department: operation()
      Department->>+DB: Database query
      DB-->>-Department: Return data
      Department-->>-DepartmentsController: Return result
    else Direct response
      Note over DepartmentsController: Process without database
    end
    DepartmentsController-->>-R: Return response
    R-->>C: Response
    
    Note over DepartmentsController: Generic operation flow
  