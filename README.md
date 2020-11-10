# OpenStreetMap Carto - Ansible

## Data import & Tiles rendering

```cmd
ansible-playbook -vv playbook-import.yml
```

1. Create OpenStack instance ([`000-create-instance.yml`](./000-create-instance.yml))
1. Run import process
    1. Create user and group "gis"
    1. Update and upgrade packages
    1. Install dependencies ([`dependencies.yml`](./roles/import/tasks/dependencies.yml))
    1. Initialize PostgreSQL database ([`postgresql.yml`](./roles/import/tasks/postgresql.yml))
    1. Download OpenStreetMapCarto ([`openstreetmap-carto.yml`](./roles/import/tasks/process/openstreetmap-carto.yml))
    1. Download Europe and extract Belgium ([`extract.yml`](./roles/import/tasks/process/extract.yml))
    1. Import data in PostgreSQL ([`import.yml`](./roles/import/tasks/process/import.yml))
1. Render tiles ([`render.yml`](./roles/import/tasks/process/render.yml))
1. Copy tiles to `tile.openstreetmap.be` server ([`800-sync-tiles.yml`](./800-sync-tiles.yml))
1. Delete OpenStack instance ([`999-delete-instance.yml`](./999-delete-instance.yml))

### Options

| Name          | Description                                 | Note                                                  |
|---------------|---------------------------------------------|-------------------------------------------------------|
| `osm_url`     |                                             | <https://download.geofabrik.de/> (format: `.osm.pbf`) |
| `poly_url`    |                                             | <http://polygons.openstreetmap.fr/> (poly)            |
| `geojson_url` |                                             | <http://polygons.openstreetmap.fr/> (GeoJSON)         |
| `tile_dir`    |                                             |                                                       |
| `style`       |                                             | Available values: `osmbe`, `osmbe-fr`, `osmbe-nl`     |
| `num_threads` | Number of threads available on your server. |                                                       |

## Documentation

### Inventory

File: `/etc/ansible/hosts`  
Documentation: <https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html>

```ini
tile.geo6.be ansible_user=ubuntu ansible_ssh_user=ubuntu
```

### Configuration OpenStack (OVH)

File: `~/.config/openstack/clouds.yaml`  
Documentation: <https://docs.openstack.org/python-openstackclient/latest/configuration/index.html>

```yaml
---
clouds:
  ovh:
    auth:
      auth_url: https://auth.cloud.ovh.net/v3/
      user_domain_name: Default
      project_domain_name: Default
      tenant_id:
      tenant_name:
      username:
      password:
```

### Useful commands

#### Key list

```cmd
openstack keypair list --os-cloud ovh --os-identity-api-version 3
```

#### Flavor list

```cmd
openstack flavor list --os-cloud ovh --os-identity-api-version 3
```

#### Image list

```cmd
openstack image list --os-cloud ovh --os-identity-api-version 3
```

---

*Thanks a lot to [@julienfastre](https://github.com/julienfastre) from [Champs-Libres](https://github.com/Champs-Libres) for all the help.*
