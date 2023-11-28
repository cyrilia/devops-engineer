# AWS Monitoring and Logging

## AWS CloudWatch

AWS CloudWatch is a comprehensive monitoring and logging service that helps you collect and track data from various AWS resources and applications, providing insights into your cloud infrastructure's performance, availability, and health.

**Note**
    - CloudWatch Events has been renamed **EventBridge**, but it's more than a fancy name. You can create custom events for Eventbrigde.
    - CloudWatch Events and EventBridge share the same API, so the old code is still valid (EventBridge is fully backward compatible)

### CloudWatch Concepts:

* **CloudWatch Metrics**:

* They are time-ordered data points published to CloudWatch.
* They only exist in the region where they are created. 
* They can't be deleted, but expire after 15 months if no new data is published to them.
* Services can have multiple different metrics stored in **namespaces**
* API actions can be used to publish and retrieve data to and from CloudWatch.
    A **namespace** is a container for cloudwatch metrics, used to isolate different application and service metrics. We can create custom namespaces for custom metrics.
    Example namespaces:
    * EBS - AWS/EBS
    * ELB - AWS/ELB
    * EC2 - AWS/EC2

**CloudWatch Periods**
This allows us to control what data is aggregated in statistics and can be used for alarms

**CloudWatch Dimensions**
They represent a name/value pair that uniquely identifies a metric.
    * Example EC2 metric dimensions: InstanceId, InstanceType, ImageId, AutoScalingGroupName
    * Example ELB metric dimensions: AvailabilityZone,loadBalancerName

## EventBridge (Extended CloudWatch Events)
Key words: Event, Rule, Target
Once EventBridge receives an event, we create a rule or select an existing rule for that event then route/apply the event to a specific target. 

## Differences between CloudWatch Events and EventBridge:
- CloudWatch Events has been renamed EventBridge.
- EventBrigdge has additional functionanlity (extends cloudwatch events (*has not replaced it*))
- You can create custom application-level events and publish them to EventBridge.

## Uses of CloudWatch (Eventbrigde) for monitoring and Logging

* **Monitoring AWS Resources**: CloudWatch can collect and display metrics on various AWS resources, including EC2 instances, RDS databases, and S3 buckets, allowing you to monitor their performance and resource utilization.

* **Custom metrics**: You can create custom metrics to monitor specific aspects of your application or system, which is useful for tracking business-specific KPIs.
    *For instance, we can create custom metrics, such as **memory utilization** which is often more accurate for scaling instances.*

* **CloudWatch Alarms**: You can set alarms based on defined thresholds to be notified when specific metrics breach those thresholds. Alarms can be set up for auto scaling (scale up), but also for underutilized instances(scale down). (CloudWatch Alarms monitor metrics we select.)
    *CloudWatch alarms can play a key part in automation. Alarms can be used to trigger Autoscaling, SNS notifications (or Slack), or (in special cases) a lambda function.*

* **Logs and Events**: CloudWatch Logs lets you store, monitor, and access log files from your resources. CloudWatch Events can respond to changes in your AWS environment and initiate automated actions. 

* **Dashboards**: CloudWatch offers customizable dashboards for visualizing the metrics and logs, helping you gain a quick overview of your infrastructure.

    NB: Metrics publish data points about the load balancer and backend instances; and retrieve statistics about data points as an ordered set of time-series data. (Metrics are indices or measurements at a ppoint in time for a system)
    On the other hand, logs provide information regarding requests made to the load balancer. (They capture info about a specific event)

## Useful case scenario of CloudWatch
Suppose you run a web application on AWS, and it experiences periodic surges in traffic (requiring more CPU and memory utilization). By using CloudWatch, you can set up alarms to monitor the application's CPU and memory utilization. When usage exceeds predefined limits, CloudWatch triggers alarms that auto-scale your application by adding more instances. This automatic scaling ensures your application stays responsive during traffic spikes, improving user experience.

## Centralized Logging in AWS
Setting up centralized logging in an AWS environment ensures data integrity and ease of access for analysis:

**Log Streams**: Use services like AWS CloudWatch Logs to centralize logs from multiple resources into a single location.

**Log Groups**: Organize logs into logical groups to manage and analyze them effectively.

**Retain Logs**: Define retention policies to store logs for an appropriate duration.

**Access Control**: Implement IAM permissions to control who can access and manage logs.

**Integration**: Integrate with analysis tools like Amazon Elasticsearch, AWS Lambda, or third-party services for in-depth analysis.

## Significance of Monitoring AWS Resources
Monitoring AWS resources is crucial for various reasons:

**Proactive Issue Identification**: It helps in detecting and addressing issues before they impact users, reducing downtime.

**Resource Optimization**: Insights from monitoring enable resource optimization, helping you control costs.

**Incident Response**: It forms the basis for a swift and effective incident response, allowing you to identify the root cause and resolve incidents quickly.

## AWS CloudTrail
CloudTrail monitors and records account activity across your AWS infrastrucure. (Records user activity and API usage).
CloudTrail can be accessed via AWS Management console, AWS Tools ad SDKs, and the AWS CLI.
CloudTrail monitors events for your account. If you create a trail, it delivers those events as log files to your Amazon S3 bucket. If you create an event data store in CloudTrail Lake, events are logged to your event data store.
Use cases for AWS cloudTrail are auditing, security, monitorig and operational troubleshoting.
    **CloudTrail logs are stored on S3.**

### Services that interact with CloudTrail
* Amazon VPC
* Amazon EC2
* Amazon RDS
* Amazon EBS
* IAM


## AWS CloudTrail vs. CloudWatch

AWS CloudTrail and AWS CloudWatch serve different purposes:

**AWS CloudTrail** records API calls made on your account and provides an audit trail for security and compliance. It's not primarily for real-time monitoring but rather for governance, compliance, and security analysis.

**AWS CloudWatch** is a real-time monitoring service that collects and displays metrics and logs to help you understand and respond to changes in your AWS environment.

*Use CloudTrail for security and compliance auditing, and CloudWatch for real-time monitoring, alarming, and operational insights.*

## Importance of Alarms and Notifications
Setting up alarms and notifications in AWS monitoring and logging solutions is critical for timely incident response. A critical alert setup might involve:

**Metric Selection**: Choose a relevant metric, such as CPU utilization or error rates, as the basis for the alarm.

**Thresholds**: Define appropriate threshold values that trigger the alarm.

**Actions**: Specify actions to take when the alarm is triggered, such as sending an SNS notification, auto-scaling, or invoking a Lambda function.

**Notification Recipients**: Configure who receives the notifications, which may include on-call teams or individuals responsible for incident resolution.

*Proactive alerting ensures that you can respond quickly to issues, minimizing downtime and user impact.*

### Note:
AWS config provides insights on how resources were changed, whereas, CloudTrail informs on where, when, what and who made changes.