defmodule Sampo.MoveCommand do
  use Kalevala.Command

  def north(conn, _params) do
    conn
    |> request_movement("north")
    |> assign(:prompt, false)
  end

  def south(conn, _params) do
    conn
    |> request_movement("south")
    |> assign(:prompt, false)
  end

  def east(conn, _params) do
    conn
    |> request_movement("east")
    |> assign(:prompt, false)
  end

  def west(conn, _params) do
    conn
    |> request_movement("west")
    |> assign(:prompt, false)
  end
end
