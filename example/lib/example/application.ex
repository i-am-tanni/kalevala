defmodule Example.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    listener_config = [
      tls: [
        keyfile: Path.join(:code.priv_dir(:example), "certs/key.pem"),
        certfile: Path.join(:code.priv_dir(:example), "certs/cert.pem")
      ],
      foreman: [
        initial_controller: Example.LoginController
      ]
    ]

    children = [
      {Kalevala.Foreman.Supervisor, [name: Kalevala.Foreman.Supervisor]},
      {Kalevala.Telnet.Listener, listener_config}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Example.Supervisor]
    Supervisor.start_link(children, opts)
  end
end