module ActiveAdminDslExtensions
  module IndexTableFor
    def link_column(name, data=nil)
      data ||= name
      column(name, data) do |ar|
        link_to ar.try(data).presence || ar.id, [:admin, ar]
      end
    end

    def edit_links(options = {})
      options = {
        :name => ""
      }.merge(options)
      column options[:name] do |resource|
        links = ''.html_safe
        if controller.action_methods.include?('edit')
          links << link_to(I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link")
        end
        if controller.action_methods.include?('destroy')
          links << link_to(I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :data => {:confirm => I18n.t('active_admin.delete_confirmation')}, :class => "member_link delete_link")
        end
        links
      end
    end
  end
end