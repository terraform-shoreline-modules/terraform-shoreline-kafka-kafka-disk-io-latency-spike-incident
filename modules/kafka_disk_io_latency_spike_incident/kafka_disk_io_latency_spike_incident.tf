resource "shoreline_notebook" "kafka_disk_io_latency_spike_incident" {
  name       = "kafka_disk_io_latency_spike_incident"
  data       = file("${path.module}/data/kafka_disk_io_latency_spike_incident.json")
  depends_on = [shoreline_action.invoke_kafka_topic_cleanup]
}

resource "shoreline_file" "kafka_topic_cleanup" {
  name             = "kafka_topic_cleanup"
  input_file       = "${path.module}/data/kafka_topic_cleanup.sh"
  md5              = filemd5("${path.module}/data/kafka_topic_cleanup.sh")
  description      = "Implement data retention policies to limit the amount of data stored on the Kafka brokers, and periodically archive or delete older data to free up disk space and improve disk I/O performance."
  destination_path = "/tmp/kafka_topic_cleanup.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_kafka_topic_cleanup" {
  name        = "invoke_kafka_topic_cleanup"
  description = "Implement data retention policies to limit the amount of data stored on the Kafka brokers, and periodically archive or delete older data to free up disk space and improve disk I/O performance."
  command     = "`chmod +x /tmp/kafka_topic_cleanup.sh && /tmp/kafka_topic_cleanup.sh`"
  params      = ["AMOUNT_OF_TIME_TO_RETAIN_MESSAGES_IN_MILLISECONDS","NAME_OF_KAFKA_TOPIC_TO_CLEAN_UP","PATH_TO_KAFKA_HOME_DIRECTORY"]
  file_deps   = ["kafka_topic_cleanup"]
  enabled     = true
  depends_on  = [shoreline_file.kafka_topic_cleanup]
}

