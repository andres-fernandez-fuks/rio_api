Sequel.migration do
  up do
    add_column :publicaciones, :estado, Numeric
  end

  down do
    drop_column :publicaciones, :estado
  end
end
