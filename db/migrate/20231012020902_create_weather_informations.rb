class CreateWeatherInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :weather_informations do |t|
      t.integer :zip_code
      t.jsonb :data

      t.timestamps
    end
  end
end
