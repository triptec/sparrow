defmodule Sparrow.PageController do
  use Sparrow.Web, :controller
  import HTTPoison
  plug :action
  
  def index(conn, _params) do
    articles = [
      fn -> {:latest, ContentService.Article.latest_articles()["articles"]} end,
      fn -> {:trending, ContentService.Article.trending_articles()["articles"]} end,
      fn -> {:page, ContentService.Article.latest_articles()["articles"]} end
    ] 
    |> Enum.map(&Task.async/1) 
    |> Enum.map(&(Task.await(&1)))
    
    latest = Enum.find_value(articles, fn({:latest, value}) -> value; _ -> false end )
    trending = Enum.find_value(articles, fn({:trending, value}) -> value; _ -> false end )
    page = Enum.find_value(articles, fn({:page, value}) -> value; _ -> false end )

    IO.inspect length(latest)
    IO.inspect length(trending)
    IO.inspect length(page)
    render conn, "index.html", trending: trending, latest: latest, page: page
  end
end
