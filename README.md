# Projector HSA Home work #20: DB Sharding

## Tasks:

1. Create 3 docker containers: postgresql-b, postgresql-b1, postgresql-b2
   Setup horizontal/vertical sharding as it’s described in this lesson and with alternative tool (citus, pgpool-|| postgres-xl)
2. Insert 1 000 000 rows into books.
   Measure performance for reads and writes.
3. Do the same without sharding. Compare performance of 3 cases (without sharding, FDW, and approach of your choice).

## Instructions:

### Single PostgreSQL Node:

1. Run docker-compose file

```bash
docker-compose -f docker-compose-single-node.yaml up
```

2. Connect to DB
3. Run [create-table.gql](./sql/single-node/create-table.sql) script
4. Run [insert.sql](./sql/insert.sql) script
5. Run [select.sql](./sql/select.sql) script

### FDW (foreign data wrapper) Sharding

1. Run docker-compose file

```bash
docker-compose -f docker-compose-fdw.yaml up
```

2. Connect to DBs (Shard 1, Shard 2, Master)
3. Run [create-table-shard1.gql](./sql/fdw/create-table-shard1.sql) script on Shard 1 DB
4. Run [create-table-shard2.gql](./sql/fdw/create-table-shard2.sql) script on Shard 2 DB
5. Run [setup-master.gql](./sql/fdw/setup-master.sql) script on Master DB
6. Run [insert.sql](./sql/insert.sql) script
7. Run [select.sql](./sql/select.sql) script

### Citus Sharding

1. Run docker-compose file

```bash
docker-compose -f docker-compose-citus.yaml up
```

2. Connect to DB
3. Run [setup-master.gql](./sql/citus/setup-master.sql) script
4. Run [insert.sql](./sql/insert.sql) script
5. Run [select.sql](./sql/select.sql) script

# Result Comparison Table

| Approach    | INSERT 1_000_000 rows | SELECT 10_000 rows |
| ----------- | --------------------- | ------------------ |
| Single Node | 68,302 ms             | 41,614 ms          |
| FDW         | 117,979 ms            | 49,081 ms          |
| Citus       | 33,863 ms             | 32,699 ms          |
