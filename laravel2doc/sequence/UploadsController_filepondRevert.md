sequenceDiagram
    autonumber
    participant C as Client
    participant R as Route
    participant UploadsController as UploadsController
    participant Upload as Upload
    participant DB as Database
    
    C->>R: Request
    R->>+UploadsController: filepondRevert()
    Note over UploadsController: Process request
    alt Uses database
      UploadsController->>+Upload: operation()
      Upload->>+DB: Database query
      DB-->>-Upload: Return data
      Upload-->>-UploadsController: Return result
    else Direct response
      Note over UploadsController: Process without database
    end
    UploadsController-->>-R: Return response
    R-->>C: Response
    
    Note over UploadsController: Generic operation flow
  