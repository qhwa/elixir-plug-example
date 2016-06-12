defmodule Router do
  defmacro __using__(_opts) do
    quote do
      def init(options) do
        options
      end

      def call(conn, _opts) do
        route(conn.method, conn.path_info, conn)
      end
    end
  end
end

defmodule User do
  use Ecto.Model

  schema "users" do
    field :first_name, :string
    field :last_name, :string
  end
end

defmodule HelloPlug do

  use Router
  require EEx
  import Plug.Conn

  EEx.function_from_file :defp, :template_show_user, "template/show_user.eex", [:user]

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http HelloPlug, []
  end

  def route("GET", ["hello"], conn) do
    conn |> send_resp(200, "Hello world")
  end

  def route("GET", ["users", user_id], conn) do
    case HelloPlug.Repo.get(User, user_id) do
      nil ->
        conn |> send_resp(404, "User with that ID not found, sorry")

      user ->
        page_content = template_show_user(user)
        conn
          |> put_resp_content_type("text/html")
          |> send_resp(200, page_content)
    end

  end

  def route(_method, _path, conn) do
    conn |> send_resp(404, "Couldn't find that page, sorry!")
  end

end

