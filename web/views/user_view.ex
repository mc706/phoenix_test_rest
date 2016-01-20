defmodule TestRest.UserView do
  use TestRest.Web, :view

  def render("index.json", %{users: users, type: type}) do
     resp = %{data: render_many(users, TestRest.UserView, "user.json")}
     IO.puts type
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, TestRest.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{data: %{id: user.id,
      username: user.username,
      email: user.email,
      crypted_password: user.crypted_password}}
  end

  def render("user_options.json", _params) do
     %{
        name: "List of Users Endpoint",
        description: "Get and modify list of users",
        renders: ["application/json", "application/json+hal"],
        parses: ["application/json"],
        actions: %{
            POST: %{
                username: %{
                    type: "string",
                    required: true,
                    read_only: false,
                    label: "Username",
                    help_text: "Required. 30 characters or fewer. Letters, digits and @/./+/-/_ only.",
                    max_length: 30
                },
                first_name: %{
                    type: "string",
                    required: false,
                    read_only: false,
                    label: "First name",
                    max_length: 30
                },
                last_name: %{
                    type: "string",
                    required: false,
                    read_only: false,
                    label: "Last name",
                    max_length: 30
                },
                email: %{
                    type: "email",
                    required: false,
                    read_only: false,
                    label: "Email address",
                    max_length: 75
                }
            }
        }
     }
  end




end
