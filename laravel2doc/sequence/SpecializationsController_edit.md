sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant SpecializationsController as SpecializationsController
    participant V as Validator
    participant Specialization as Specialization
    participant DB as Database
    
    C->>R: PUT /resource/{id}
    R->>+SpecializationsController: edit(request, id)
    SpecializationsController->>+V: validate(request)
    V-->>-SpecializationsController: validated data
    SpecializationsController->>+Specialization: find(id)
    Specialization->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Specialization: Return record
    Specialization-->>-SpecializationsController: Model instance
    SpecializationsController->>+Specialization: update(data)
    Specialization->>+DB: UPDATE table SET ... WHERE id = ?
    DB-->>-Specialization: Success
    Specialization-->>-SpecializationsController: Updated model
    SpecializationsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over SpecializationsController,Specialization: This sequence updates an existing resource
  