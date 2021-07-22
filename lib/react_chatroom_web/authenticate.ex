defmodule ReactChatroomWeb.Authenicate do
  @user_salt "rwlkzxncx"

  def sign(data) do
    Phoenix.Token.sign(ReactChatroomWeb.Endpoint, @user_salt, data)
  end

  def verify(token) do
    Phoenix.Token.verify(ReactChatroomWeb.Endpoint, @user_salt, token, max_age: 365 * 24 * 3600)
  end

  @s Hashids.new(salt: @user_salt)
  def encode(id) do
    Hashids.encode(@s, id)
  end

  def decode(cipher1) do
    {:ok, [id]} = Hashids.decode(@s, cipher1)
    id
  end
end
