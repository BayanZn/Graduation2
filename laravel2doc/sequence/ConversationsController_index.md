sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ConversationsController as ConversationsController
    participant Message as Message
    participant DB as Database
    
    C->>R: GET /resource
    R->>+ConversationsController: index()
    ConversationsController->>+Message: all() / get() / paginate()
    Message->>+DB: SELECT * FROM table
    DB-->>-Message: Return records
    Message-->>-ConversationsController: Collection of models
    ConversationsController-->>-R: Return JSON response
    R-->>C: 200 OK with data
    
    Note over ConversationsController,Message: This sequence retrieves a list of resources
  