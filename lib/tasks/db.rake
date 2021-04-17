namespace :db do
  task :backup do
    system "mysqldump --opt --user=ieconsultores --password iec2010 userdetails> xyz.sql"
  end

  task :restore do
    system "mysqldump --user=ieconsultores --password  < xyz.sql"
  end
end