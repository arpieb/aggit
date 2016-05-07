defmodule Aggit.ViewHelpers do
  @moduledoc """
  Provide general-purpose helper functions to extend Phoenix.HTML on for view rendering.
  """

  use Phoenix.HTML

  @doc """
  Generates standard markup for field help text.

  The form should either be a `Phoenix.HTML.Form` emitted
  by `form_for` or an atom.

  All given options are forwarded to the underlying tag.

  ## Examples

      help_text("Please provide your full name.")
      #=> <small>Please provide your full name.</small>

      help_text("Please provide your email.", class: "text-muted")
      #=> <small class="text-muted">Please provide your email.</small>

      help_text do
        "Please provide your email."
      end
      #=> <small>Please provide your email.</small>

      help_text class: "text-muted" do
        "Please provide your email."
      end
      #=> <small class="text-muted">Please provide your email.</small>
  """
  def help_text(text) when is_binary(text) do
    help_text(text, [])
  end
  def help_text([do: block]) do
    help_text([], do: block)
  end

  @doc """
  See `help_text/1`.
  """
  def help_text(text, opts) when is_binary(text) and is_list(opts) do
    name = :small
    opts = Keyword.put(opts, :class, "text-muted")
    content = [tag(name, opts), raw(text), {:safe, "</#{name}>"}]
    |> Enum.map(&(elem(&1, 1)))
    |> Enum.join()
    {:safe, content}
  end
  def help_text(opts, [do: block]) do
    help_text(block, opts)
  end

  def safe_link(text, opts \\ []) do
    case link(text, opts) do
      {:safe, parts} -> Enum.join(parts)
      _ -> ""
    end
  end
end
