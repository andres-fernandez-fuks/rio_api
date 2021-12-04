Sequel.migration do
  up do
    add_column :ofertas, :estado, String, size: 50
  end

  down do
    drop_column :ofertas, :estado
  end
end
