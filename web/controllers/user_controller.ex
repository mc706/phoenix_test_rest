defmodule TestRest.UserController do
  use TestRest.Web, :controller

  alias TestRest.User

  plug :scrub_params, "user" when action in [:index_post, :update]

  def index_get(conn, _params) do
    users = Repo.all(User)
    requested = get_req_header(conn, "accept")
    conn
    |> put_resp_header("e-tag", etag_for_data(users))
    |> render("index.json", users: users, type: requested)
  end

  def index_post(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
        {:ok, user } ->
            conn
            |> put_status(:created)
            |> put_resp_header("e-tag", etag_for_data(user))
            |> put_resp_header("location", user_path(conn, :show, user))
            |> render("show.json", user: user)
        {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> render("error.json", changeset: changeset)
    end
  end

  def index_options(conn, _params) do
       conn
       |> put_status(:ok)
       |> render("user_options.json")
  end

  ## Below is auto generated

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(TestRest.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    send_resp(conn, :no_content, "")
  end

  # Error responses
  def not_allowed(conn, _params) do
    conn
    |> put_status(:method_not_allowed)
  end

  defp etag_for_data(data) do
      data
      |> :erlang.phash2()
      |> Integer.to_string(16)
  end

end

