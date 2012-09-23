ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #   span :class => "blank_slate" do
    #     span "Welcome to Active Admin. This is the default dashboard page."
    #     small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
    #   end
    # end


    columns do
      column do

        panel "New Users" do
          ul do 
            User.order(:id.desc).limit(5).map do |u|
              li link_to(u.name, [:admin, u]) + " / #{u.created_at}"
            end
          end
        end

        panel "New Stories" do
          ul do 
            Story.order(:id.desc).includes(:user, :series).limit(5).map do |ar|
              li do
                link_to(ar.title, [:admin, ar]) + 
                if ar.series
                  raw(" (##{ar.series_position} of #{link_to ar.series.title, [:admin, ar.series]})")
                else
                  ""
                end +
                raw(" by ") + 
                link_to(ar.user.name, [:admin, ar.user]) + " / #{ar.created_at}"
              end
            end
          end
        end

        panel "New Series" do
          ul do 
            Series.order(:id.desc).includes(:user).limit(5).map do |ar|
              li do
                link_to(ar.title, [:admin, ar]) + raw(" by ") + link_to(ar.user.name, [:admin, ar.user]) + " / #{ar.created_at}"
              end
            end
          end
        end

      end # column
      column do

        panel "Recently Banned Users" do
          ul do 
            User.where{banned_at != nil }.order(:banned_at.desc).limit(5).map do |u|
              li link_to(u.name, [:admin, u]) + " / #{u.banned_at}"
            end
          end
        end

        panel "Recently Locked Stories" do
          ul do 
            Story.where{locked_at != nil }.order(:locked_at.desc).limit(5).map do |u|
              li link_to(u.name, [:admin, u]) + " / #{u.locked_at}"
            end
          end
        end

      end # column
      column do

        panel "Quick Links" do
          ul do
            li do
              link_to "Create News Post", new_admin_news_post_path
            end
            li do
              link_to "Create Page", new_admin_page_path
            end
          end
        end

        panel "Pending News Posts Users" do
          ul do 
            NewsPost.where(published_at: nil).order(:id.desc).limit(5).map do |u|
              li link_to(u.name, [:admin, u])
            end
          end
        end

        panel "Pending Pages Series" do
          ul do 
            Page.where(published: false).order(:id.desc).includes(:user).limit(5).map do |ar|
              li do
                link_to(ar.title, [:admin, ar]) + raw(" by ") + link_to(ar.user.name, [:admin, ar.user])
              end
            end
          end
        end

      end #column
    end #columns


    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
