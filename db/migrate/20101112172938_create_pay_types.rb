class CreatePayTypes < ActiveRecord::Migration
  def self.up
    create_table :pay_types do |t|
      t.string :pay_type

      t.timestamps
    end
  end

  def self.down
    drop_table :pay_types
  end
end
