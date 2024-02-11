defmodule LiveNodeWeb.Jq.CoreTest do
  alias LiveNodeWeb.Jq.Core
  use LiveNodeWeb.ConnCase, async: true

  test "get_jq_cmd" do
    out = Core.get_jq_cmd(%{opts: %{path: "abc.json"}})
    assert(out == {"jq", [".", "abc.json"]})
  end

  test "get_jq_cmd 2" do
    out = Core.get_jq_cmd(%{opts: %{path: "test/live_node_web/jq/jq_test_json.json"}})
    assert(out == {"jq", [".", "abc.json"]})
  end

  test "get_format_jq_cmd" do
    out = Core.get_format_jq_cmd("in.json", "out.json")
  end

  test "format_json" do
    out = Core.format_json("test/live_node_web/jq/jq_test_json.json", "test/live_node_web/jq/jq_test_json_formatted.json")
    assert(out == :ok)
  end
end
