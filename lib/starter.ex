defmodule HelloPlug.Starter do
  
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(HelloPlug, []),
      worker(HelloPlug.Repo, [])
    ]

    opts = [strategy: :one_for_one, name: HelloPlug]

    Supervisor.start_link(children, opts)
  end

end
