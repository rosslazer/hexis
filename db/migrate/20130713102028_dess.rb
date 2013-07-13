class Dess < ActiveRecord::Migration
  def change
    change_table :desires do |t|

      t.string :name
      t.belongs_to :user

    end
  end
end
