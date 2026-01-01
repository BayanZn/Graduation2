sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant MessagesController as MessagesController
    participant V as Validator
    participant Model as Model
    participant DB as Database
    
    C->>R: POST /resource
    R->>+MessagesController: store(request)
    MessagesController->>+V: validate(request)
    V-->>-MessagesController: validated data
    MessagesController->>+Model: create(data)
    Model->>+DB: INSERT INTO table
    DB-->>-Model: Return new record
    Model-->>-MessagesController: New model instance
    MessagesController-->>-R: Return JSON response
    R-->>C: 201 Created with data
    
    Note over MessagesController,Model: This sequence creates a new resource
  