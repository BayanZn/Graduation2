sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant SpecializationsController as SpecializationsController
    participant Specialization as Specialization
    participant DB as Database
    
    C->>R: GET /resource
    R->>+SpecializationsController: index()
    SpecializationsController->>+Specialization: all() / get() / paginate()
    Specialization->>+DB: SELECT * FROM table
    DB-->>-Specialization: Return records
    Specialization-->>-SpecializationsController: Collection of models
    SpecializationsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over SpecializationsController,Specialization: This sequence retrieves a list of resources
  