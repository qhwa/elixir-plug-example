defmodule HelloPlug.Repo do

  use Ecto.Repo,
    otp_app: :hello_plug,
    adapter: Sqlite.Ecto

end

