Sequel.migration do
  up do
    add_column :publicaciones, :estado, String, size: 50
  end

  down do
    drop_column :publicaciones, :estado
  end
end
