class CreateCategorizationsJoin < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.references :post
      t.references :category
    end
  end

end
