
defmodule LiveNodeWeb.Jq.Core do

  def get_jq_cmd(%{opts: %{filter: jq_filter, path: path}}) do
    cmd = "jq"

    args = [
      jq_filter,
      path
    ]
    {cmd, args}
  end

  def get_jq_cmd(%{opts: %{path: path}}) do
    cmd = "jq"

    args = [
      ".",
      path
    ]
    {cmd, args}
  end


  def format_json(path_in, path_out) do
    {cmd, args} = get_format_jq_cmd(path_in, path_out)

    case System.cmd(cmd, args) do
      {output, 0} ->
        IO.puts("Command executed successfully: #{output}")
      {error, status} ->
        IO.puts("Command failed with error: #{error}, status: #{status}")
    end
  end

  def get_format_jq_cmd(path_in, path_out) do
    command =
      case :os.type() do
        :unix -> "jq '.' " <> path_in <>" > " <> path_out
        {:unix, :linux} -> "jq '.' " <> path_in <>" > " <> path_out
        :win32 -> "jq \".\" " <> path_in <>" > " <> path_out
        _ -> raise "Unsupported operating system"
      end

    {"sh", ["-c", command]}
  end

end

