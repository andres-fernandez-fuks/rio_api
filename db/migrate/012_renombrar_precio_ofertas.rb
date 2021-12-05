Sequel.migration do
  up do
    alter_table(:ofertas) do
      rename_column :precio, :monto
    end
  end

  down do
    alter_table(:ofertas) do
      rename_column :monto, :precio
    end
  end
end
