sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ConversationsController as ConversationsController
    participant Model as Model
    participant DB as Database
    
    C->>R: GET /resource/{id}
    R->>+ConversationsController: show(id)
    ConversationsController->>+Model: find(id) / findOrFail(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-ConversationsController: Model instance
    ConversationsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over ConversationsController,Model: This sequence retrieves a specific resource by ID
  