defmodule UnLibD.Logger do
  @moduledoc false

  def error(message) do
    IO.puts(
        IO.ANSI.red() <>
        IO.ANSI.bright() <>
        "Error: " <>
        IO.ANSI.reset() <>
        IO.ANSI.red() <>
        message <>
        IO.ANSI.reset()
    )
  end

  def info(message) do
    IO.puts(
        IO.ANSI.blue() <>
        IO.ANSI.bright() <>
        "Info: " <>
        IO.ANSI.reset() <>
        IO.ANSI.blue() <>
        message <>
        IO.ANSI.reset()
    )
  end

  def success(message) do
    IO.puts(
        IO.ANSI.blue() <>
        IO.ANSI.green() <>
        "[V] " <>
        IO.ANSI.reset() <>
        IO.ANSI.green() <>
        message <>
        IO.ANSI.reset()
    )
  end
end
