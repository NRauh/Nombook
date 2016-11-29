defmodule Nombook.RecipeTest do
  use Nombook.ModelCase

  alias Nombook.Recipe

  @valid_attrs %{
    cook_time: "35-40 Minutes",
    cooking_method: "Oven",
    description: "A nice cherry pie from Twin Peaks",
    diet: "None",
    ingredients: [
      %{amount: 1, unit: "c", what: "flour"},
      %{amount: 0.5, unit: "c", what: "Crisco"},
      %{amount: 0.25, unit: "c", what: "ice water"},
      %{amount: 3, unit: "c", what: "cherries"},
      %{amount: 1, unit: "c", what: "water"},
      %{amount: 1, unit: "c", what: "sugar"},
      %{amount: 4, unit: "T", what: "cornstarch"},
      %{amount: 0.125, unit: "t", what: "salt"}
    ],
    instructions: [
      %{section: "crust", instruction: "Mix flour and Crisco with fork."},
      %{section: "crust", instruction: "Add ice water."},
      %{section: "crust", instruction: "Mix with your hands."},
      %{section: "crust", instruction: "When blended, roll into ball and refrigerate overnight."},
      %{section: "crust", instruction: "To roll out: flour both rolling pin and flat surface, split ball in two, roll out 1/2 to fit pan and 1/2 for lattice."},
      %{section: "Filling", instruction: "Thaw cherries at room temp and strain (yields 2 c juice)."},
      %{section: "Filling", instruction: "Taste for sweetness, more/less sugar may be needed."},
      %{section: "Filling", instruction: "Add 1 c water to make 3 c juice (reserve 1 c juice for cornstarch mix)."},
      %{section: "Filling", instruction: "Dissolve cornstarch in 1 c juice, stir with whip."},
      %{section: "Filling", instruction: "Combine 2 c juice, 2/3 c sugar, salt, and bring to a boil."},
      %{section: "Filling", instruction: "Add cornstarch mix, cook until clear, about 5 min (if cooked too long, syrup gets gummy)."},
      %{section: "Filling", instruction: "Remove from heat, stir in 1/3 c sugar (blend thoroughly)."},
      %{section: "Filling", instruction: "Pour mixture over cherries, fold with wooden spoon, cool (stir mix while cooling to prevent scum from forming on top)."},
      %{section: "Filling", instruction: "Pour mix inpie shell."},
      %{section: "Filling", instruction: "Top completed pie with lattice crust"}
    ],
    nutrition: [
      %{item: "calories", amount: "250", unit: "kcal"}
    ],
    origin: "http://www.lynchnet.com/tp/tpcard07.html",
    prep_time: "30 min (and day for crust)",
    serving_size: "1/8 of pie",
    servings: "8 slices",
    title: "Twin Peaks Cherry Pie",
    total_time: "1 hour (not including crust wait time)"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Recipe.changeset(%Recipe{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Recipe.changeset(%Recipe{}, @invalid_attrs)
    refute changeset.valid?
  end
end
