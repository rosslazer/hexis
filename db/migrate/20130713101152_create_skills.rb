class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|

      t.timestamps
      t.string :name
      t.belongs_to :user


    end
  end
end
