# 守护进程集（DaemonSet）

## 简介

DaemonSet 配置主要说明如何在 Wayne 平台上创建和管理 DaemonSet

## 创建

拥有 DAEMONSET_CREATE 权限的用户可以在前台自助创建 DaemonSet，管理员用户也可以在后台创建和编辑 DaemonSet。

![](../images/admin-daemonset.gif?classes=border,shadow)

元数据说明：

```
{
	  // 可选，要使用特权模式的容器名称 , 为了安全，用户端高级模式编辑的特权模式相关配置会被自动覆盖
	  "privileged":{"nginx":true},
	  // 可选，亲和性相关配置，会自动覆盖用户端高级模式编辑的亲和性
	  "affinity": {
	    "podAntiAffinity": {
	      "requiredDuringSchedulingIgnoredDuringExecution": [
	        {
	          "labelSelector": {
	            "matchExpressions": [
	              {
	                "operator": "In",
	                "values": [
	                  "xxx"
	                ],
	                "key": "app"
	              }
	            ]
	          },
	          "topologyKey": "kubernetes.io/hostname"
	        }
	      ]
	    }
	  },
	  // 资源使用相关
	  "resources":{
			"cpuRequestLimitPercent": "50%", // cpu request 和 limit 百分比，默认 50%
			"memoryRequestLimitPercent": "100%", // memory request 和 limit 百分比，默认 100%
			"cpuLimit":"12",  // cpu 限制，默认 12 个核
			"memoryLimit":"64" // 内存限制，默认 64G
	  }
	}
```