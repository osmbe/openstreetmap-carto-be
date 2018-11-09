# Rendering

- Server A : Database
- Server B : Rendering server
- Server C : Tile server

## Update OpenStreetMap data

Run `data-update.sh` on *Server A* :

1. Update "openstreetmap-carto-be"
2. Clean data
3. Get last version of Europe
4. Create Belgium extract (based on bounding box)
5. Import data in PostgreSQL

You will need to use `~/.pgpass` file to define the password to connect to PostgreSQL : <https://www.postgresql.org/docs/current/libpq-pgpass.html>.

## Update generic data

Run `~/src/openstreetmap-carto-be/scripts/get-shapefiles.py` on *Server B*

## Render tiles

Run `process.sh [fr|nl]` on *Server B* :

1. Update "openstreetmap-carto-be" and "render_list_geo.pl"
2. Generate `mapnik.xml`
3. Start `renderd`
4. Delete existing tiles (if any)
5. Render levels 0-8 (no bounding box)
6. Render levels 9-18 (bounding box)
7. Copy the new tiles on *Server C*

To give the ability to Mapnik to connect to external database, configure it in `project.mml` file (line 31) : <https://github.com/mapnik/mapnik/wiki/PostGIS>.  
You can use `~/.pgpass` file to define the password : <https://www.postgresql.org/docs/current/libpq-pgpass.html>.
