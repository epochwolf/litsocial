ActiveAdmin.register Version do

  actions :index, :show

  controller do
    with_role :admin
  end

  batch_action :destroy, false # remove batch operations on users
end