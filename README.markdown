# Engine kpi

## Lanzar a mano el cálculo de la última semana:

    > Kpi::Semanal.calcula_ultima_semana

## Migraciones

Una migración no funciona si se lanza en el root del engine:

    > rails g migration add_tematica_id_to_redirections tematica_id:integer

    => script/rails:8:in 'require': cannot load such file -- rails/engine/commands (LoadError)
    => from script/rails:8:in 'main>'

Hay que lanzarla en dummy:

    > cd test/dummy
    > rails g migration add_tematica_id_to_redirections tematica_id:integer

    => invoke  active_record
    => create    db/migrate/20130626151549_add_tematica_id_to_redirections.rb

    > mv db/migrate/20130626151549_add_tematica_id_to_redirections.rb ../../db/migrate/
    > rake db:migrate


Luego, habrá que importar las migraciones a la app principal que vaya a usar el engine:

    > rnk
    > rake kpi:install:migrations
    > rdbp

## Conexión app-engine

### En la app:

En usuario.rb, se añaden los scopes que el modelo proporciona con una línea:
`  include Kpi::UsuarioKpi`

Y lo mismo para el resto de modelos afectados.
Puede consultarse con un comando todos los modelos a los que se les va a añadir scopes:

    > Kpi::MODELOS_AFECTADOS


### En el engine:

Dummy necesitará tener creados los modelos afectados, con sus correspondientes tablas


### Configurar para que use la working copy local

    > bundle config local.kpi ../kpi

### Deshacer configuración para volver a usar git en lugar de la working copy

    > bundle config --delete local.kpi

## Control de versiones

### Incrementar versión en el código

Cuando el cambio ya está _mergeado_ en `master`, es hora de incrementar el contador de versiones para hacer la subida. En `lib/kpi/version.rb`:

    module Kpi
      VERSION = "0.5.1"
    end

### Escribir changelog

En `changelog.txt`, se comentan las características que se han añadido en esta versión.

###  Subir cambios a git y crear _tag_

En la línea de comandos, desde el directorio del engine:

    > git commit -m "Cambio de version"
    > git push origin
    > git tag 0.1.0
    > git push origin 0.1.0

### App principal

Una vez esta creado el _tag_ de la nueva versión, vamos a las aplicaciones principales y editamos la línea del Gemfile:

    gem 'kpi', git: 'git@github.com:Soluciones/kpi.git', branch: 'master', tag: '0.1.0'


Y lanzamos `bundle update --source kpi` para que actualice a la nueva versión.
