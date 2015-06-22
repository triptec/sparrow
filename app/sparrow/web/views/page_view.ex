defmodule Sparrow.PageView do
  use Sparrow.Web, :view

  def img_tag(img_url) do
    {:safe, "<img src='#{img_url}/16_9/600.jpg' />"}
  end

  def build_image_url(uuid) do
    Application.get_env(:sparrow, Sparrow.Endpoint)[:image_service_uri] <> "/api/v1/images/#{uuid}"
  end

  def teaser_image(article) do
    case article["teaser"]["image"] do
      %{"uuid" => uuid} when is_nil(uuid) != true ->
        IO.inspect uuid
        img_src = build_image_url(uuid)
        img_tag(img_src)
      _ ->
        ""
    end
  end
end
