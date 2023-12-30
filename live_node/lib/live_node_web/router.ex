defmodule LiveNodeWeb.Router do
  use LiveNodeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LiveNodeWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveNodeWeb do
    pipe_through :browser

    live_session :default do
      #admin
      live "/todo", TodoLive
      live "/promo", PromoLive
      live "/vega-lite-examples", VegaLiteExamples
      live "/add-link", AddLink
    end

    get "/link/", LinkController, :index
    get "/link/:url", LinkController, :show

    # templates
    live "/templates", TemplateLive.Index, :index
    live "/templates/new", TemplateLive.Index, :new
    live "/templates/:id/edit", TemplateLive.Index, :edit

    live "/templates/:id", TemplateLive.Show, :show
    live "/templates/:id/show/edit", TemplateLive.Show, :edit

    # notes
    live "/notes", NoteLive.Index, :index
    live "/notes/new", NoteLive.Index, :new
    live "/notes/:id/edit", NoteLive.Index, :edit

    live "/notes/:id", NoteLive.Show, :show
    live "/notes/:id/show/edit", NoteLive.Show, :edit


    # default that came with generated project
    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveNodeWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:live_node, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LiveNodeWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
