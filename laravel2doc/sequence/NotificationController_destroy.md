sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant NotificationController as NotificationController
    participant Model as Model
    participant DB as Database
    
    C->>R: DELETE /resource/{id}
    R->>+NotificationController: destroy(id)
    NotificationController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-NotificationController: Model instance
    NotificationController->>+Model: delete()
    Model->>+DB: DELETE FROM table WHERE id = ?
    DB-->>-Model: Success
    Model-->>-NotificationController: Success
    NotificationController-->>-R: Return JSON response
    R-->>C: 204 No Content
    
    Note over NotificationController,Model: This sequence removes a resource
  