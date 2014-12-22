require 'rake'
Rake::Task.clear

Tematica::Tematica.delete_all
seed_query = "INSERT INTO tematica_tematicas (id, nombre, portada_path, seccion_publi, created_at, updated_at)
VALUES
  (1, 'Depósitos y cuentas', '/depositos-y-cuentas', 'depositos,cuentas', '2012-12-10 15:24:46', '2012-12-10 15:24:46'),
  (2, 'Fondos', '/fondos-de-inversion/portada', 'fondos', '2012-12-10 15:24:46', '2012-12-10 15:24:46'),
  (3, 'Hipotecas', '/hipotecas-y-creditos', 'vivienda', '2012-12-10 15:24:46', '2012-12-10 15:24:46');"

ActiveRecord::Base.connection.execute seed_query
