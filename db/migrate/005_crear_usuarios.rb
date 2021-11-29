Sequel.migration do
  up do
    create_table(:usuarios) do
      primary_key :id
      String :nombre
      String :mail
      String :id_telegram
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:usuarios)
  end
end
