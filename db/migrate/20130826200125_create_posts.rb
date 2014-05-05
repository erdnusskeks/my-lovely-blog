# How did we create this?
# With the command "$ rails generate model Post title:string text:text" we told Rails that we want a Post model,
# together with a TITLE ATTRIBUTE of type STRING, and a TEXT ATTRIBUTE of type TEXT.
# Those attributes are automatically added to the posts table in the database and mapped to the Post model.

# Active Record is smart enough to automatically map column names to model attributes, which means you don't
# have to declare attributes inside Rails models, as that will be done automatically by Active Record.

class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end

# "rails generate model" created a database migration file inside the db/migrate directory.
# Migrations are Ruby classes that are designed to make it simple to create and modify database tables.
# Rails uses rake commands to run migrations, and it's possible to undo a migration after it's been applied to your database.
# Migration filenames include a timestamp to ensure that they're processed in the order that they were created.


# The above migration creates a method named "change" which will be called when you run this migration.
# The action defined in this method is also reversible, which means Rails knows how to reverse the change made by
# this migration, in case you want to reverse it later.

# When you run this migration it will create a posts table with one string column and a text column.
# It also creates two timestamp fields to allow Rails to track post creation and update times.


