Sequel.migration do
  up do
    create_table(:ofertas) do
      primary_key :id
      Numeric :precio
      foreign_key :oferente, :usuarios
      foreign_key :publicacion, :publicaciones
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:ofertas)
  end
end
