sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant SpecializationsController as SpecializationsController
    participant V as Validator
    participant Specialization as Specialization
    participant DB as Database
    
    C->>R: POST /resource
    R->>+SpecializationsController: store(request)
    SpecializationsController->>+V: validate(request)
    V-->>-SpecializationsController: validated data
    SpecializationsController->>+Specialization: create(data)
    Specialization->>+DB: INSERT INTO table
    DB-->>-Specialization: Return new record
    Specialization-->>-SpecializationsController: New model instance
    SpecializationsController-->>-R: Return JSON response
    R-->>C: 201 Created with data
    
    Note over SpecializationsController,Specialization: This sequence creates a new resource
  