

#!/bin/bash



# Define variables

KAFKA_HOME=${PATH_TO_KAFKA_HOME_DIRECTORY}

TOPIC=${NAME_OF_KAFKA_TOPIC_TO_CLEAN_UP}

RETENTION_TIME=${AMOUNT_OF_TIME_TO_RETAIN_MESSAGES_IN_MILLISECONDS}



# Set retention policy for Kafka topic

$KAFKA_HOME/bin/kafka-topics.sh --alter --topic $TOPIC --config retention.ms=$RETENTION_TIME



# Clean up old messages from Kafka topic

$KAFKA_HOME/bin/kafka-topics.sh --alter --topic $TOPIC --config cleanup.policy=compact