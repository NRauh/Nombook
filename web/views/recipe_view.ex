defmodule Nombook.RecipeView do
  use Nombook.Web, :view

  def render("index.json", %{recipes: recipes}) do
    %{recipes: render_many(recipes, Nombook.RecipeView, "recipe.json")}
  end

  def render("show.json", %{recipe: recipe}) do
    %{recipe: render_one(recipe, Nombook.RecipeView, "recipe.json")}
  end

  def render("recipe.json", %{recipe: recipe}) do
    %{id: recipe.id,
      title: recipe.title,
      description: recipe.description,
      origin: recipe.origin,
      cook_time: recipe.cook_time,
      prep_time: recipe.prep_time,
      total_time: recipe.total_time,
      cooking_method: recipe.cooking_method,
      diet: recipe.diet,
      serving_size: recipe.serving_size,
      servings: recipe.servings,
      nutrition: recipe.nutrition,
      ingredients: recipe.ingredients,
      instructions: recipe.instructions}
  end
end
