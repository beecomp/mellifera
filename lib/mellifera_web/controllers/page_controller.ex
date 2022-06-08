defmodule MelliferaWeb.PageController do
  use MelliferaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
