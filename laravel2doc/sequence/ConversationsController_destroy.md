sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ConversationsController as ConversationsController
    participant Model as Model
    participant DB as Database
    
    C->>R: DELETE /resource/{id}
    R->>+ConversationsController: destroy(id)
    ConversationsController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-ConversationsController: Model instance
    ConversationsController->>+Model: delete()
    Model->>+DB: DELETE FROM table WHERE id = ?
    DB-->>-Model: Success
    Model-->>-ConversationsController: Success
    ConversationsController-->>-R: Return JSON response
    R-->>C: 204 No Content
    
    Note over ConversationsController,Model: This sequence removes a resource
  