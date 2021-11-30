Sequel.migration do
  up do
    create_table(:publicaciones) do
      primary_key :id
      Numeric :precio
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:usuarios)
  end
end
