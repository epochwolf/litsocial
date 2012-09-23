namespace :users do
  desc "Promote a user to admin. Required variable: USER"
  task :promote => :environment do
    if user = User.find_by_name(ENV['USER'])
      user.update_column(:admin, true)
      user.update_column(:banned_at, nil)
    else
      puts "No user found by that name"
    end
  end

  desc "Demote a user to non-admin. Required variable: USER"
  task :demote => :environment do
    if user = User.find_by_name(ENV['USER'])
      user.update_column(:admin, false)
    else
      puts "No user found by that name"
    end
  end
end