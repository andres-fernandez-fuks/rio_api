Sequel.migration do
  up do
    add_column :publicaciones, :auto, Numeric
  end

  down do
    drop_column :publicaciones, :auto
  end
end
