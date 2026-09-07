class FixFollowForeignKeys < ActiveRecord::Migration[7.1]
  def up
    execute "PRAGMA foreign_keys = OFF"

    execute <<~SQL
      CREATE TABLE follows_new (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        follower_id INTEGER NOT NULL REFERENCES users(id),
        following_id INTEGER NOT NULL REFERENCES users(id),
        created_at DATETIME NOT NULL,
        updated_at DATETIME NOT NULL
      )
    SQL

    execute <<~SQL
      INSERT INTO follows_new (id, follower_id, following_id, created_at, updated_at)
      SELECT id, follower_id, following_id, created_at, updated_at FROM follows
    SQL

    execute "DROP TABLE follows"
    execute "ALTER TABLE follows_new RENAME TO follows"

    execute "CREATE INDEX index_follows_on_follower_id ON follows (follower_id)"
    execute "CREATE INDEX index_follows_on_following_id ON follows (following_id)"

    execute "PRAGMA foreign_keys = ON"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end