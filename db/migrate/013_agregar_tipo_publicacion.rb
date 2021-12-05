Sequel.migration do
  up do
    add_column :publicaciones, :tipo, String, size: 50
  end

  down do
    drop_column :publicaciones, :tipo
  end
end
