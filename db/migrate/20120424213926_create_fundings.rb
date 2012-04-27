class CreateFundings < ActiveRecord::Migration
  def change
    create_table :fundings do |t|
      t.integer :company_id
      t.string :year
      t.integer :amount

      t.timestamps
    end
  end
end
