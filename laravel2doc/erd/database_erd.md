erDiagram
  conversation {
    int id PK "Primary key"
    string type
    int project_id FK "References project"
    string name
    datetime last_message_at
    string created_by FK "References user"
    int user_id FK "References user"
    int conversation_id FK "References conversation"
    int sender_id FK "References sender"
    datetime created_at
    datetime updated_at
  }
  conversationparticipant {
    int id PK "Primary key"
    int conversation_id FK "References conversation"
    int user_id FK "References user"
    string role
    float unread_count
    datetime last_read_at
    datetime joined_at
    datetime created_at
    datetime updated_at
  }
  defense {
    int id PK "Primary key"
    datetime discussion_date
    int project_id FK "References project"
    int created_by FK "References user"
    int user_id FK "References user"
    datetime created_at
    datetime updated_at
  }
  message {
    int id PK "Primary key"
    int conversation_id FK "References conversation"
    int sender_id FK "References user"
    string message
    string type
    datetime read_at
    int user_id FK "References user"
    datetime created_at
    datetime updated_at
  }
  messageread {
    int id PK "Primary key"
    int message_id FK "References message"
    int user_id FK "References user"
    datetime read_at
    datetime created_at
    datetime updated_at
  }
  project {
    int id PK "Primary key"
    int specialization_id FK "References specialization"
    int department_id FK "References department"
    int user_id FK "References user"
    int project_id FK "References project"
    datetime created_at
    datetime updated_at
  }
  projectassignment {
    int id PK "Primary key"
    datetime assigned_at
    int project_id FK "References project"
    int user_id FK "References user"
    int assigned_by FK "References user"
    datetime created_at
    datetime updated_at
  }
  projectrequest {
    int id PK "Primary key"
    json group_members
    datetime reviewed_at
    int project_id FK "References project"
    int student_id FK "References user"
    int reviewed_by FK "References user"
    datetime created_at
    datetime updated_at
  }
  projectsubmission {
    int id PK "Primary key"
    datetime reviewed_at
    int project_id FK "References project"
    int uploaded_by FK "References user"
    int reviewed_by FK "References user"
    datetime created_at
    datetime updated_at
  }
  setting {
    int id PK "Primary key"
    int currency_id FK "References currency"
    datetime created_at
    datetime updated_at
  }
  user {
    int id PK "Primary key"
    string name
    string email
    string password
    string mobile
    string address
    string gender
    string first_name
    string last_name
    datetime date_of_birth
    datetime email_verified_at
    int sender_id FK "References sender"
    datetime created_at
    datetime updated_at
  }
  setting }|--|| currency : "currency"
  user ||--|{ projectassignment : "assignments"
  user ||--|{ message : "messages"
  user }|--|{ conversation : "conversations"
