
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Kafka Disk IO Latency Spike Incident
---

This incident type refers to a sudden increase in disk input/output (I/O) latency in the Kafka message broker, which can lead to degraded performance, slow processing of messages, and potentially impact system availability. This may be caused by a variety of factors, such as hardware failure, network issues, or software bugs. It is important to quickly identify and resolve this issue to prevent disruption to the system and ensure smooth operation of the Kafka message broker.

### Parameters
```shell
export DISK_NAME="PLACEHOLDER"

export PATH_TO_KAFKA_LOGS="PLACEHOLDER"

export AMOUNT_OF_TIME_TO_RETAIN_MESSAGES_IN_MILLISECONDS="PLACEHOLDER"

export NAME_OF_KAFKA_TOPIC_TO_CLEAN_UP="PLACEHOLDER"

export PATH_TO_KAFKA_HOME_DIRECTORY="PLACEHOLDER"
```

## Debug

### Check the current CPU usage
```shell
top
```

### Check if Kafka is running
```shell
systemctl status kafka
```

### Check the current disk usage
```shell
df -h
```

### Check the disk I/O utilization
```shell
iostat -x ${DISK_NAME}
```

### Check the disk I/O wait time
```shell
iostat -x ${DISK_NAME} | grep -E 'avgqu-sz|await'
```

### Check the current network usage
```shell
nload
```

### Check the Kafka logs for any errors or warnings
```shell
tail -f ${PATH_TO_KAFKA_LOGS}
```

## Repair

### Implement data retention policies to limit the amount of data stored on the Kafka brokers, and periodically archive or delete older data to free up disk space and improve disk I/O performance.
```shell


#!/bin/bash



# Define variables

KAFKA_HOME=${PATH_TO_KAFKA_HOME_DIRECTORY}

TOPIC=${NAME_OF_KAFKA_TOPIC_TO_CLEAN_UP}

RETENTION_TIME=${AMOUNT_OF_TIME_TO_RETAIN_MESSAGES_IN_MILLISECONDS}



# Set retention policy for Kafka topic

$KAFKA_HOME/bin/kafka-topics.sh --alter --topic $TOPIC --config retention.ms=$RETENTION_TIME



# Clean up old messages from Kafka topic

$KAFKA_HOME/bin/kafka-topics.sh --alter --topic $TOPIC --config cleanup.policy=compact


```