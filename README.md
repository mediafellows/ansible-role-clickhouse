[![Ansible-Test](https://github.com/mediafellows/ansible-role-clickhouse/workflows/Ansible-Test/badge.svg)](https://github.com/mediafellows/ansible-role-clickhouse/actions?query=workflow%3AAnsible-Test)

# Ansible Clickhouse role

Simple clickhouse-server deploy and management role. For ubuntu or debian server.

This is a fork of https://github.com/AlexeySetevoi/ansible-clickhouse

## Role Variables

Most variables have sane defaults, but you can of course overwrite them in your play.
See `defaults/main.yml` for an overwiev of all vars.

You can manage listen ports

```yaml
clickhouse_http_port: 8123
clickhouse_tcp_port: 9000
clickhouse_interserver_http: 9009
```

you can manage listen ip:

```yaml
clickhouse_listen_hosts:
  - "192.168.0.1"
```

You can create custom profiles
```yaml
clickhouse_profiles:
 my_custom_profile:
   max_memory_usage: 10000000000
   use_uncompressed_cache: 0
   load_balancing: random
   my_super_param: 9000
```


You can set-up users like this:

```yaml
clickhouse_users:
      - { name: "testuser",
          password_sha256_hex: "f2ca1bb6c7e907d06dafe4687e579fce76b37e4e93b7605022da52e6ccc26fd2",
          networks: "{{ clickhouse_networks_default }}",
          profile: "default",
          quota: "default",
          dbs: [ testu1 ] ,
          comment: "classic user with plain password"}
      - { name: "testuser2",
          password: "testplpassword",
          networks: "{{ clickhouse_networks_default }}",
          profile: "default",
          quota: "default",
          dbs: [ testu2 ] ,
          comment: "classic user with hex password"}
      - { name: "testuser3",
          password: "testplpassword",
          networks: { 192.168.0.0/24, 10.0.0.0/8 },
          profile: "default",
          quota: "default",
          dbs: [ testu1,testu2,testu3 ] ,
          comment: "classic user with multi dbs and multi-custom network allow password"}
```

You can manage own quotas:
```yaml
clickhouse_quotas:
 - { name: "my_custom_quota", intervals: "{{ clickhouse_quotas_intervals_default }}",comment: "Default quota - count only" }
```
Quote object is simple dict:
```yaml
 - { duration: 3600, queries: 0, errors: 0,result_rows: 0,read_rows: 0,execution_time: 0 }
```

F: You can create any databases:
default db state - present
```yaml
clickhouse_dbs:
      - { name: testu1 }
      - { name: testu2 }
      - { name: testu3 }
      - { name: testu4, state: absent }
      - { name: testu4, state: present }
```

## Example Playbook

Example playbook setting up Clickhouse server with a custom data dir and to be accessible in a IPv4 network. Relying on the default setting for the rest.

```yaml
  - hosts: localhost
    become: true
    vars:
      clickhouse_path_data: /data/clickhouse/
      clickhouse_http_port: 8123
      clickhouse_allowed_networks:
        - 10.10.0.0/16
      clickouse_listen_hosts:
        - 0.0.0.0
    roles:
      - mediafellows.clickhouse
```

## License

BSD

## Author Information

[ClickHouse](https://clickhouse.yandex/docs/en/index.html) by [Yandex LLC](https://yandex.ru/company/).

Role by [AlexeySetevoi](https://github.com/AlexeySetevoi).

Dear contributors, thank you.
