class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :tag,          index: true
      t.references :taggable,     index: true
      t.string     :taggable_type
      t.timestamps
    end
  end
end
