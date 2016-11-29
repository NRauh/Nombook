defmodule Nombook.Router do
  use Nombook.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Nombook do
    pipe_through :api
    resources "/recipes", RecipeController, except: [:new, :edit, :extractor]
  end
end
