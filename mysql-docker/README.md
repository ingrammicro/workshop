mysql-docker helper Cookbook
============================

The `mysql-docker` cookbook can be used to install and run a MySQL Server Docker container.
When included as is in your cookbook, runs MySQL on port 3306 with 'mysql' as password for the 'root' user.

Requirements
------------

Nothing special.


Attributes
----------
#### docker-mysql::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
    <th>Optional</th>
  </tr>
  <tr>
    <td><tt>[:mysql][:root_password]</tt></td>
    <td>string</td>
    <td>The password to be set for the root user</td>
    <td><tt>mysql</tt></td>
    <td>yes</td>
  </tr>
  <tr>
    <td><tt>[:mysql][:version]</tt></td>
    <td>string</td>
    <td>The version of MySQL to be installed</td>
    <td><tt>5.6.23</tt></td>
    <td>yes</td>
  </tr>
  <tr>
    <td><tt>[:mysql][:hostname]</tt></td>
    <td>string</td>
    <td>The hostname for the MySQL container</td>
    <td><tt>mysql</tt></td>
    <td>yes</td>
  </tr>
  <tr>
    <td><tt>[:mysql][:publishport]</tt></td>
    <td>integer</td>
    <td>The port on which the MySQL container listens in the host machine</td>
    <td><tt>3306</tt></td>
    <td>yes</td>
  </tr>
  <tr>
    <td><tt>[:mysql][:dir]</tt></td>
    <td>string</td>
    <td>The directory where the MySQL configuration should be stored on the host machine (docker volume binding)</td>
    <td><tt>/var/lib/mysql</tt></td>
    <td>yes</td>
  </tr>
  <tr>
    <td><tt>[:mysql][:app][:database]</tt></td>
    <td>string</td>
    <td>If specified, a new database will be created with that name</td>
    <td><tt></tt></td>
    <td>yes</td>
  </tr>
  <tr>
    <td><tt>[:mysql][:app][:username]</tt></td>
    <td>string</td>
    <td>If specified, a new user will be created with GRANT ALL on the [:mysql][:app][:database]</td>
    <td><tt></tt></td>
    <td>yes</td>
  </tr>
  <tr>
    <td><tt>[:mysql][:app][:password]</tt></td>
    <td>string</td>
    <td>Sets the password for the MySQL user [:mysql][:app][:username]</td>
    <td><tt></tt></td>
    <td>yes</td>
  </tr>
</table>


Usage
-----
#### mysql-docker::default

Just include `mysql-docker` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mysql-docker]"
  ]
}
```

License and Authors
-------------------
Authors: Pieter Temmerman - Ingram Micro
