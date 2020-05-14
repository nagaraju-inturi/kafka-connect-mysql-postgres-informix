
#To delete connectors...
echo "First delete connectors if they were already registered..."
curl -X DELETE localhost:8083/connectors/mysql-sql-source
curl -X DELETE localhost:8083/connectors/postgres-sql-source
curl -X DELETE localhost:8083/connectors/mysql-informix-sql-sink
curl -X DELETE localhost:8083/connectors/postgres-informix-sql-sink

echo ""
echo "Create source connector for MYSQL..."
echo ""
#Create source connector for MYSQL
curl -X POST -H "Content-Type":"application/json" -d '{"name": "mysql-sql-source", "config":{"connector.class":"io.confluent.connect.jdbc.JdbcSourceConnector", "tasks.max":"1", "connection.url":"jdbc:mysql://mysql:3306/testdb", "connection.user":"connect_user", "connection.password":"asgard", "mode":"timestamp+incrementing", "timestamp.column.name":"entry_date", "incrementing.column.name":"prod_id", "topic.prefix":"mysql" }}' http://localhost:8083/connectors

echo ""
#List connectors
curl -s "http://localhost:8083/connectors"
echo ""
echo ""

sleep 1

#Create source connector for PostgreSQL
echo ""
echo "Create source connector for PostgreSQL..."
echo ""
curl -X POST -H "Content-Type":"application/json" -d '{"name": "postgres-sql-source", "config":{"connector.class":"io.confluent.connect.jdbc.JdbcSourceConnector", "tasks.max":"1", "connection.url":"jdbc:postgresql://postgres:5432/postgres", "connection.user":"connect_user", "connection.password":"asgard", "mode":"timestamp+incrementing", "timestamp.column.name":"update_ts", "incrementing.column.name":"customer_id", "topic.prefix":"postgres" }}' http://localhost:8083/connectors

echo ""
#List connectors
curl -s "http://localhost:8083/connectors"
echo ""
echo ""

sleep 1

#Create sink connector for MySQL to Informix
echo ""
echo "Create SINK connector for MySQL to Informix ..."
echo ""
curl -X POST -H "Content-Type: application/json" -d '{"name": "mysql-informix-sql-sink", "config": {"connector.class":"io.confluent.connect.jdbc.JdbcSinkConnector", "tasks.max":"1", "topics":"mysqlproducts", "connection.url":"jdbc:informix-sqli://informix:9088/testdb", "connection.user":"informix", "connection.password":"in4mix", "mode":"upsert", "table.name.format":"products", "pk.mode":"record_value", "pk_fields":"record_value","pk.fields":"prod_id","auto.create": "true" ,"auto.evolve": "true"}}' http://localhost:8083/connectors

echo ""
#List connectors
curl -s "http://localhost:8083/connectors"
echo ""
echo ""

sleep 1

#Create sink connector for PostgreSQL to Informix
echo ""
echo "Create SINK connector for PostgreSQL to Informix ..."
echo ""
curl -X POST -H "Content-Type: application/json" -d '{"name": "postgres-informix-sql-sink", "config": {"connector.class":"io.confluent.connect.jdbc.JdbcSinkConnector", "tasks.max":"1", "topics":"postgrescustomers", "connection.url":"jdbc:informix-sqli://informix:9088/testdb", "connection.user":"informix", "connection.password":"in4mix", "mode":"upsert", "table.name.format":"customers", "pk.mode":"record_value", "pk_fields":"record_value","pk.fields":"customer_id","auto.create": "true" ,"auto.evolve": "true"}}' http://localhost:8083/connectors

echo ""
#List connectors
curl -s "http://localhost:8083/connectors"
echo ""
echo ""

sleep 1


#Check connector status
echo ""
echo "Check mysql-sql-source connector status..."
echo ""
curl -s "http://localhost:8083/connectors/mysql-sql-source/status"
echo ""
echo "Check postgres-sql-source connector status..."
echo ""
curl -s "http://localhost:8083/connectors/postgres-sql-source/status"
echo ""
echo "Check mysql-informix-sql-sink connector status..."
echo ""
curl -s "http://localhost:8083/connectors/mysql-informix-sql-sink/status"
echo ""
echo "Check postgres-informix-sql-sink connector status..."
echo ""
curl -s "http://localhost:8083/connectors/postgres-informix-sql-sink/status"
echo ""

