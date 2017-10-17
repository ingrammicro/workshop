# acronis-gateway
Installs and configures Acronis Storage Gateway as a docker container with some mounts on the host:
- /var/lib/Acronis/storage
- /var/lib/Acronis/acronis-storage-mds
- /etc/pki/tls/certs/Acronis/storage
- /var/log/Acronis
- /etc/Acronis/acronis-storage-gateway.xml
- /etc/Acronis/acronis-storage-mds.xml
- /etc/Acronis/acronis-storage-backend-azure.xml, only if `azure` is selected as backend
- /etc/Acronis/acronis-storage-backend-s3.xml, only if `s3` is selected as backend
- /etc/Acronis/acronis-storage-backend-swift.xml, only if `swift` is selected as backend

## Attributes

| Name | Type | Default | Description | Required |
|------|------|---------|-------------|----------|
| `acronis-gateway/image` | string | ingrammicro/acronis-gateway:latest | Docker image with Acronis Gateway software to use | optional |
| `acronis-gateway/image_tag` | string | latest | Specific tag for Docker image with Acronis Gateway software to use | optional |
| `acronis-gateway/port` | string | 44445 | Port on which Acronis Storage Gateway will be listening | required |
| `acronis-gateway/backend` | One of `local`,`azure`,`s3`,`swift` | local | Storage Backend where Acronis Storage Gateway will store your backup: a `local` directory in the machine or an `azure`, `s3` or (OpenStack) `swift` account | optional |
| `acronis-gateway/home_path` | string | /var/lib/Acronis/storage | Path at the storage backend on which Acronis Storage Gateway will store your files | required if backend is `azure`, `s3` or `swift` |
| `acronis-gateway/chunk_storage_path` | string |  | Path at the storage backend on which Acronis Storage Gateway will store chunks | required if backend is `s3` or `swift` |
| `acronis-gateway/login` | string |  | The login for your administrator account in Acronis Backup Cloud | required |
| `acronis-gateway/password` | string |  | The password for your administrator account in Acronis Backup Cloud | required |
| `acronis-gateway/mgmt_console_host` | string | cloud.acronis.com | The web address of the Acronis Backup Cloud management console | optional |
| `acronis-gateway/gateway_fqdn` | string | FQDN for the server | The public DNS name or public IP of the gateway | optional |
| `acronis-gateway/storage_id` | string | read from /etc/Acronis/storage_id or randomly generated | A unique name for the storage that will be desplayed on the Storage tab of the Acronis Backup Cloud management console | optional |
| `acronis-gateway/s3_access_key_id` | string |  | The Access Key ID for the S3 account to use as backend | required if backend is `s3` |
| `acronis-gateway/s3_region` | string | us-east-1 | The S3 region for the S3 account to use as backend | optional |
| `acronis-gateway/s3_secret_access_key` | string |  | The Secret Access Key for the S3 account to use as backend | required if backend is `s3` |
| `acronis-gateway/azure_account` | string |  | The name of the Microsoft Azure account to use as backend | required if backend is `azure` |
| `acronis-gateway/azure_access_key` | string |  | The secondary access key for the Microsoft Azure account to use as backend | required if backend is `azure` |
| `acronis-gateway/swift_api_version` | One of `v1`,`v2`,`v3` | v3 | The API version used by the Keystone identity service providing access to the OpenStack Swift account to use as backend | optional |
| `acronis-gateway/swift_keystone_service_url` | string |  | The URL for the Keystone identity service providing access to the OpenStack Swift account to use as backend | required if backend is `swift` |
| `acronis-gateway/swift_user_domain_id` | string | default | The domain ID for the user of the OpenStack Swift account to use as backend | optional |
| `acronis-gateway/swift_user_name` | string |  | The name for the user of the OpenStack Swift account to use as backend | required if backend is `swift` |
| `acronis-gateway/swift_password` | string |  | The password for the user of the OpenStack Swift account to use as backend | required if backend is `swift` |
| `acronis-gateway/swift_project_domain_id` | string | default | The domain ID for the project of the OpenStack Swift account to use as backend | optional |
| `acronis-gateway/swift_project_name` | string |  | The domain ID for the project of the OpenStack Swift account to use as backend | required if backend is `swift` |
