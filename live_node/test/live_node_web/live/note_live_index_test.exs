defmodule LiveNodeWeb.NoteLiveTest do
  use LiveNodeWeb.ConnCase, async: true

  test "abc" do
    assert true
  end


# url_encode64(data, opts \\ [])View Source
# @spec url_encode64(binary(), keyword()) :: binary()
# Encodes a binary string into a base 64 encoded string with URL and filename safe alphabet.
#
# Accepts padding: false option which will omit padding from the output string.
#
# Examples
# iex> Base.url_encode64(<<255, 127, 254, 252>>)
# "_3_-_A=="
#
# iex> Base.url_encode64(<<255, 127, 254, 252>>, padding: false)
# "_3_-_A"
 
  test "round trip simple url encode/decode demo" do
    data = "www.abc.com"
    opts = []
    encoded = Base.url_encode64(data, opts)
    decoded = Base.url_decode64(encoded, opts)

    case decoded do
      {:ok, decoded_data} -> assert decoded_data = data
      {:error, _} -> assert false
    end
  end

  test "round trip url encode/decode demo" do
    data = "https://www.youtube.com/watch?v=R7t7zca8SyM"
    opts = []
    encoded = Base.url_encode64(data, opts)
    decoded = Base.url_decode64(encoded, opts)

    case decoded do
      {:ok, decoded_data} -> assert decoded_data = data
      {:error, _} -> assert false
    end
  end



end
