namespace :db do
  task :backup do
    system "mysqldump --opt --user=root --password rose userdetails> xyz.sql"
  end

  task :restore do
    system "mysqldump --user=root --password  < xyz.sql"
  end
end