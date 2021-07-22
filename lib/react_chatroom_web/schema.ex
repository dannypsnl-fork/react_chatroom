defmodule ReactChatroomWeb.Schema do
  use Absinthe.Schema

  import_types(ReactChatroomWeb.Schema.Account)
  import_types(ReactChatroomWeb.Schema.Room)
  import_types(ReactChatroomWeb.Schema.Message)

  query do
    import_fields(:room_queries)
    import_fields(:message_queries)
  end

  mutation do
    import_fields(:account_mutations)
    import_fields(:room_mutations)
    import_fields(:message_mutations)
  end
end
