class CreateWeatherInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :weather_informations do |t|
      t.string :postal_code
      t.string :country_code
      t.jsonb :data

      t.timestamps
    end
  end
end
