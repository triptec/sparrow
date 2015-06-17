defmodule Sparrow.PageController do
  use Sparrow.Web, :controller
  import HTTPoison
  plug :action

  defp call_url(url) do
    case HTTPoison.get(url, [{"Content-Type", "application/hal+json"}, {"Accept", "application/hal+json"}, {"Authorization", "Token token=d59712fddb44372d659f6e41bb533214"}]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 302, body: _body, headers: headers}} ->
        location = headers |> Enum.find_value fn {"Location", value} -> value; _ -> false end
        IO.puts "302 " <> location
        call_url(location)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end  
  end
  
  def myGet(url) do
    case call_url(url) do
      {:ok, body} ->
        IO.puts "OK!"
        Poison.decode! body
      {:error, reason} ->
        IO.puts reason
        {"articles", []}
    end  
  end
  
  def index(conn, _params) do
    articles = [fn -> myGet("https://content-service.mittmedia.se:3000/api/v1/articles/latest?site_id=LTZ") end, 
             fn -> myGet("https://content-service.mittmedia.se:3000/api/v1/articles/latest?site_id=LTZ") end,
             fn -> myGet("https://content-service.mittmedia.se:3000/api/v1/articles/latest?site_id=LTZ") end] |> Enum.map(&Task.async/1) |> Enum.map(&(Task.await(&1)))
    IO.puts length(articles)
    render conn, "index.html"
  end
end
