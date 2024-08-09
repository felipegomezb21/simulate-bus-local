#!/usr/bin/env bash

echo
echo "Create topic reg-div"
echo "------------------------------"
kafka-topics --create --bootstrap-server kafka:9092 --replication-factor 1 --partitions 1 --topic reg-div --config cleanup.policy=compact

# echo
# echo "Create topic participants"
# echo "------------------------------"
# kafka-topics --create --bootstrap-server kafka:9092 --replication-factor 1 --partitions 1 --topic participants --config cleanup.policy=compact

echo
echo "List topics"
echo "-----------"
kafka-topics --list --bootstrap-server kafka:9092