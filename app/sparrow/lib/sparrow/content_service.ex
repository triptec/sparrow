defmodule ContentService do
  defmodule Article do
    def getUrl do
      Application.get_env(:sparrow, Sparrow.Endpoint)[:content_service_uri]
    end

    def getToken do
      Application.get_env(:sparrow, Sparrow.Endpoint)[:token]
    end

    def getSiteId do
      Application.get_env(:sparrow, Sparrow.Endpoint)[:site_id]
    end

    def getParams do
      "?site_id=" <> getSiteId() <> "&limit=15"
    end
    
    def get_articles(path) do
      case ApiService.call_url(getUrl <> path <> getParams, getToken) do
        {:ok, body} ->
          IO.puts "OK!"
          Poison.decode! body
        {:error, reason} ->
          IO.puts reason
          {"articles", []}
      end
    end

    def latest_articles do
      get_articles("/api/v1/articles/latest")
    end
    
    def trending_articles do
      get_articles("/api/v1/articles/trending")
    end
    
  end
end