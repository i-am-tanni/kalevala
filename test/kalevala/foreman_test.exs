defmodule Kalevala.ForemanTest do
  use ExUnit.Case

  alias Kalevala.Character.Conn
  alias Kalevala.Character.Foreman

  describe "handling the conn" do
    test "prints lines" do
      conn = setup_conn(["Text"])
      state = setup_state()

      {:noreply, _state} = Foreman.handle_conn(conn, state)

      assert_receive {:send, %Conn.Lines{data: ["Text"]}}
    end

    test "handles halting" do
      conn = setup_conn()
      state = setup_state()

      conn = Conn.halt(conn)

      {:noreply, _state} = Foreman.handle_conn(conn, state)

      assert_receive :terminate
    end

    test "transitions to the next controller" do
      conn = setup_conn()
      state = setup_state()

      conn = Conn.put_controller(conn, ExampleController)

      {:noreply, state, {:continue, :init_controller}} = Foreman.handle_conn(conn, state)

      assert state.controller == ExampleController
    end
  end

  defp setup_conn() do
    %Conn{}
  end

  defp setup_conn(lines) do
    %Conn{
      lines: [%Conn.Lines{data: lines}]
    }
  end

  defp setup_state() do
    %Foreman{protocol: self()}
  end
end
