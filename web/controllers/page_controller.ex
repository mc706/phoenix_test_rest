defmodule TestRest.PageController do
  use TestRest.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
