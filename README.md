# LiveNode

Work-in-progress, experimenting with Elixir and trying out project ideas

## Notes


###  Install Dependencies

includes: yt-dlp

```
chmod u+x install-deps.sh && sh install-deps.sh
```


### Project creation


```bash
mix archive.install hex phx_new
```

```bash
mix phx.new live_node
```

```bash
mix ecto.create
```

```bash
mix phx.server
```

```bash
iex -S mix phx.server
