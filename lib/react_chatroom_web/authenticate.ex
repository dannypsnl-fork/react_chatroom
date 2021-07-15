defmodule ReactChatroomWeb.Authenicate do
  @user_salt "rwlkzxncx"

  def sign(data) do
    Phoenix.Token.sign(ReactChatroomWeb.Endpoint, @user_salt, data)
  end

  def verify(token) do
    Phoenix.Token.verify(ReactChatroomWeb.Endpoint, @user_salt, token, max_age: 365 * 24 * 3600)
  end
end
