defmodule ExAws.Iam.Params.AccessKey do
  @moduledoc """
  Generates query params for working with IAM access keys.

  """

  import ExAws.Iam.Utils, only: [opts_to_params: 2]

  @actions_map %{
    list: "ListAccessKeys",
    get_last_used: "GetAccessKeyLastUsed",
    create: "CreateAccessKey",
    update: "UpdateAccessKey",
    delete: "DeleteAccessKey"
  }

  @params_map %{
    action: "Action",
    access_key_id: "AccessKeyId",
    marker: "Marker",
    max_items: "MaxItems",
    status: "Status",
    username: "UserName",
    version: "Version"
  }

  @shared_params ~w[action version]a

  @doc """
  Generates query params for an IAM request for given action.

  ## Parameters

    * `action` - The action name to generate params for.

  ## Options

  A list of options to to supply for the given action.

  """
  def new(action, opts \\ []) do
    opts = Keyword.put(opts, :action, Map.get(@actions_map, action))
    params = params_for(action) ++ @shared_params
    @params_map
    |> Map.take(params)
    |> opts_to_params(opts)
  end

  @list_params ~w[marker max_items username]a
  defp params_for(:list), do: @list_params

  @get_last_used_params ~w[access_key_id]a
  defp params_for(:get_last_used), do: @get_last_used_params

  @create_params ~w[username]a
  defp params_for(:create), do: @create_params

  @update_params ~w[access_key_id status username]a
  defp params_for(:update), do: @update_params

  @delete_params ~w[access_key_id username]a
  defp params_for(:delete), do: @delete_params
end