defmodule ApiService do
  use HTTPoison.Base

  def process_url(url) do
    url
  end

  def process_response_body(body) do
    body
  end
  
  def call_url(url, token) do
    case get(url, [{"Content-Type", "application/hal+json"}, {"Accept", "application/hal+json"}, {"Authorization", "Token token=" <> token}]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

end
