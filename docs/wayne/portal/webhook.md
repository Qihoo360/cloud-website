# 行为钩子（Webhook）

## 简介
本文档主要讲解 Webhook 的设计和使用方法。

Webhook 用于处理一些事件的自动回调请求，目前支持对以下事件的回调：

- 成员（增删改等）
- 负载均衡（增删改等）
- 部署（增删改等）

Webhook 模块可以单独部署，如需使用，需要在配置中进行如下配置：

```yaml
# 所有 发布-订阅 模型的组件均需要 Rabbitmq 支持
BusRabbitMQURL = "amqp://127.0.0.1:5672"
BusEnable = true
# Webhook 需要设置开关，http 请求超时时间，以及同时处理 http 请求的窗口大小
EnableWebhook = true
WebhookClientTimeout = 10
WebhookClientWindowSize = 16
```

![创建 webhook](../images/create-webhook.png?classes=border,shadow)

您可以使用 /wayne/dev/echo.py 创建一个测试的 webhook 回调地址，来理解 webhook 的行为和数据。
