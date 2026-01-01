classDiagram
  class Conversation {
    +type
    +project_id
    +name
    +last_message_at: datetime
    +created_by
  }
  class ConversationParticipant {
    +conversation_id
    +user_id
    +role
    +unread_count
    +last_read_at: datetime
    +joined_at: datetime
  }
  class Currency {
  }
  class Defense {
  }
  class Department {
  }
  class Message {
    +conversation_id
    +sender_id
    +message
    +type
    +read_at: datetime
  }
  class MessageRead {
    +message_id
    +user_id
    +read_at: datetime
  }
  class PaymentMethod {
  }
  class Project {
  }
  class ProjectAssignment {
  }
  class ProjectRequest {
  }
  class ProjectSubmission {
  }
  class Setting {
  }
  class Specialization {
  }
  class Upload {
  }
  class User {
    +name
    +email
    +password: hashed
    +mobile
    +address
    +gender
    +first_name
    +last_name
    +date_of_birth
  }
  Setting <-- Currency : currency
  User --* ProjectAssignment : assignments
  User --* Message : messages
  User <--* Conversation : conversations
