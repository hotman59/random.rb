class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name_group
      t.string :salle
      t.string :tache

      t.timestamps null: false
    end
  end
end
