# 路由（Ingress）


## 定义

Ingress，是用来聚合集群内服务的方式，对应的是 Kubernetes 的 Ingress 资源，后端使用了 Nginx Controller 来处理具体规则。Ingress 可以给 service 提供集群外部访问的 URL、负载均衡、SSL termination、HTTP 路由等。

## 操作

![](../images/ingress.gif?classes=border,shadow)
