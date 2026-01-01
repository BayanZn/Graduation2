sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant SpecializationsController as SpecializationsController
    participant Specialization as Specialization
    participant DB as Database
    
    C->>R: Request
    R->>+SpecializationsController: export()
    Note over SpecializationsController: Process request
    alt Uses database
      SpecializationsController->>+Specialization: operation()
      Specialization->>+DB: Database query
      DB-->>-Specialization: Return data
      Specialization-->>-SpecializationsController: Return result
    else Direct response
      Note over SpecializationsController: Process without database
    end
    SpecializationsController-->>-R: Return response
    R-->>C: Response
    
    Note over SpecializationsController: Generic operation flow
  