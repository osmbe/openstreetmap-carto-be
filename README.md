# OpenStreetMap Carto - Ansible

## Data import & Tile update

```cmd
ansible-playbook playbook-import.yml
```

1. Create OpenStack instance ([`000-create-instance.yml`](./000-create-instance.yml))
1. Create user and group "gis"
1. Update and upgrade packages
1. Install dependencies ([`dependencies.yml`](./import/tasks/dependencies.yml))
1. Initialize PostgreSQL database ([`postgresql.yml`](./import/tasks/postgresql.yml))
1. Download OpenStreetMapCarto ([`openstreetmap-carto.yml`](./import/tasks/process/openstreetmap-carto.yml))
1. Download Europe and extract Belgium ([`extract.yml`](./import/tasks/process/extract.yml))
1. Import data in PostgreSQL ([`import.yml`](./import/tasks/process/import.yml))
1. Render tiles ([`render.yml`](./import/tasks/process/render.yml))
1. Copy tiles to `tile.openstreetmap.be` server ()
1. Delete OpenStack instance ([`999-delete-instance.yml`](./000-delete-instance.yml))

### Options

| Name          | Description | Note                                              |
|---------------|-------------|---------------------------------------------------|
| `poly_url`    |             | <http://polygons.openstreetmap.fr/> (poly)        |
| `geojson_url` |             | <http://polygons.openstreetmap.fr/> (GeoJSON)     |
| `tile_dir`    |             |                                                   |
| `style`       |             | Available values: `osmbe`, `osmbe-fr`, `osmbe-nl` |

## Documentation

### Key list

```cmd
openstack keypair list --os-cloud ovh --os-identity-api-version 3
```

### Flavor list

```cmd
openstack flavor list --os-cloud ovh --os-identity-api-version 3
```

### Image list

```cmd
openstack image list --os-cloud ovh --os-identity-api-version 3
```
