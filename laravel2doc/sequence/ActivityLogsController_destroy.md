sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ActivityLogsController as ActivityLogsController
    participant Model as Model
    participant DB as Database
    
    C->>R: DELETE /resource/{id}
    R->>+ActivityLogsController: destroy(id)
    ActivityLogsController->>+Model: find(id)
    Model->>+DB: SELECT * FROM table WHERE id = ?
    DB-->>-Model: Return record
    Model-->>-ActivityLogsController: Model instance
    ActivityLogsController->>+Model: delete()
    Model->>+DB: DELETE FROM table WHERE id = ?
    DB-->>-Model: Success
    Model-->>-ActivityLogsController: Success
    ActivityLogsController-->>-R: Return JSON response
    R-->>C: 204 No Content
    
    Note over ActivityLogsController,Model: This sequence removes a resource
  