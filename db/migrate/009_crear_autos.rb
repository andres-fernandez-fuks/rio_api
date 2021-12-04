Sequel.migration do
  up do
    create_table(:autos) do
      primary_key :id
      String :patente
      String :marca
      String :modelo
      Numeric :anio
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:autos)
  end
end
