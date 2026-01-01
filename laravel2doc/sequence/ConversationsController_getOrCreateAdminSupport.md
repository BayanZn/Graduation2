sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant ConversationsController as ConversationsController
    participant Conversation as Conversation
    participant DB as Database
    
    C->>R: Request
    R->>+ConversationsController: getOrCreateAdminSupport()
    Note over ConversationsController: Process request
    alt Uses database
      ConversationsController->>+Conversation: operation()
      Conversation->>+DB: Database query
      DB-->>-Conversation: Return data
      Conversation-->>-ConversationsController: Return result
    else Direct response
      Note over ConversationsController: Process without database
    end
    ConversationsController-->>-R: Return response
    R-->>C: Response
    
    Note over ConversationsController: Generic operation flow
  