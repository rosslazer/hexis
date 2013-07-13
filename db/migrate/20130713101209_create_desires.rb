class Change < ActiveRecord::Migration
  def change
    change_table :desires do |t|

      t.timestamps
      t.string :name
      t.belongs_to :user

    end
  end
end
