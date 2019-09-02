# 加密字典（Secret）

## 简介

当需要存储一些非敏感配置数据时可以使用 ConfigMap，当你想要存储一些敏感数据时使用 Secret，例如（passwords, OAuth tokens, ssh keys, credentials 等）。例如有以下 Secret：

![](../images/portal-secret-tpl.png?classes=border,shadow)

高级模式详情如下：

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: example-secret
  labels:
    wayne-app: example
    wayne-ns: demo
    app: example-secret
type: Opaque
data:
  username: YWRtaW4=
  password: MWYyZDFlMmU2N2Rm
```

> **注意：** 在表单上 Secret 的值直接填写明文，但在高级模式下 Secret 的 value 必须经过 base64。普通模式下填写明文平台会自动转换。 

### 使用方式：

####  1. 通过环境变量使用

![](../images/portal-deployment-secret.png?classes=border,shadow)

高级模式使用示例：

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secret-env-pod
spec:
  containers:
    - name: mycontainer
      image: redis
      env:
        - name: SECRET_USERNAME
          valueFrom:
            secretKeyRef:
              name: example-secret   #指定 secret 名称
              key: username    #要使用的 key
        - name: SECRET_PASSWORD
          valueFrom:
            secretKeyRef:
              name: example-secret
              key: password
```

```
$ echo $SECRET_USERNAME
admin
$ echo $SECRET_PASSWORD
1f2d1e2e67df
```

####  2. 挂载到文件

**仅支持高级模式**

``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
  namespace: default
spec:
  containers:
  - image: redis
    name: mypod
    volumeMounts:
    - mountPath: /etc/foo
      name: foo
      readOnly: true
  volumes:
  - name: foo
    secret:
      defaultMode: 420      #0644 默认文件权限，由于 json 文件不支持八进制，使用 json 时应使用十进制
      secretName: example-secret
```

运行结果：在 /etc/foo/ 目录下生成两个文件 username 和 password   

```
foo/
|-- password -> ..data/password
`-- username -> ..data/username
#cat username       admin
#cat password      1f2d1e2e67df
```

> **注意：**  自动更新： 当 Secrets 被更新时，已经挂载的 pod 不会立即更新，而要等待 kubelete 检查周期，kubelet 会定期检查 secret 变化并更新它。


####  3. 拉取镜像

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: image-test-secret
  namespace: default
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: ew0KCSJhdXRocyI6IHsNCgkJImltYWdlLXRlc3QiOiB7DQoJCQkiYXV0aCI6ICJjbTl2ZERweWIyOTAiLA0KCQkJImVtYWlsIjogIiINCgkJfQ0KCX0NCn0=
```

加密部分的明文为：

```
{
	"auths": {
		"image-test": {
			"auth": "cm9vdDpyb290",   #  密文为 "root:root"base64 的结果
			"email": ""
		}
	}
}
```

部署文件使用如下：

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: foo
  namespace: default
spec:
  containers:
    - name: foo
      image: janedoe/awesomeapp:v1
  imagePullSecrets:
    - name: image-test-secret
```

### 实际使用例子（挂载证书文件）：

```yaml
kind: Secret
apiVersion: v1
metadata:
  name: client-certs
  namespace: default
data:
  ca.pem: *** #实际使用请替换成经过 base64 加密后的内容
  kubernetes.pem: ***
  kubernetes-key.pem: ***
```

使用 deployment 部署：

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: redis
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: redis
        image: redis
        ports:
          - containerPort: 8080
        volumeMounts:
        - mountPath: /etc/kubernetes/certs
          name: my-certs
      volumes:
        - name: my-certs
          secret:
            secretName: client-certs
      imagePullSecrets:
        - name: image-test-secret
```
